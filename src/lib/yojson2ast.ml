open Util

exception Invalid_Yojson of string * Yojson.Safe.t

type record_field = {
  ptr: int;
  name: string
}

type [@warning "-37"] c_type =
  | Just of Ast.ctype
  | Alias of int
  | Pointer of int
  | Array of { ptr: int; size: int }
  | Record of { name: string; fields: record_field list; location: Ast.location }

module PointerMap = Map.Make(Int)

let resolve_ctype typemap tpe =
  let open Option.Let in
  let rec impl = function
    | Just tpe -> Some tpe
    | Alias ptr ->
      let* tpe = PointerMap.find_opt ptr typemap in
      let* tpe = impl tpe in
      Some tpe
    | Pointer ptr ->
      let* tpe = PointerMap.find_opt ptr typemap in
      let* tpe = impl tpe in
      Some (Ast.Tpointer tpe)
    | Array { ptr; size } ->
      let* tpe = PointerMap.find_opt ptr typemap in
      let* tpe = impl tpe in
      Some (Ast.Tarray (tpe, size))
    | Record { name; fields; location } ->
      let fields =
        fields
        |> List.map (fun { ptr; name } -> Option.to_list (
            let* tpe = PointerMap.find_opt ptr typemap in
            let* ctype = impl tpe in
            Some (Ast.{ ctype; name })
          ))
        |> List.flatten
      in
      Some (Ast.Trecord { name; fields; location })
  in
  impl tpe

let find_type typemap i =
  let open Option.Let in
  let* tpe = PointerMap.find_opt i typemap in
  resolve_ctype typemap tpe

let extract_pointer yojson =
  match List.assoc_opt "pointer" yojson with
  | Some (`Int ptr) -> Some ptr
  | _ -> None

let extract_location info =
  let result = Ast.empty_location in
  let result =
    match List.assoc_opt "source_range" info with
    | Some (`Tuple (`Assoc start_info :: `Assoc end_info :: _)) ->
      let result =
        match List.assoc_opt "file" start_info with
        | Some (`String file) -> { result with file= Some file }
        | _ -> result
      in
      let result =
        match List.assoc_opt "line" start_info with
        | Some (`Int line) -> { result with start_line= Some line }
        | _ -> result
      in
      let result =
        match List.assoc_opt "column" start_info with
        | Some (`Int column) -> { result with start_column= Some column }
        | _ -> result
      in
      let result =
        match List.assoc_opt "line" end_info with
        | Some (`Int line) -> { result with end_line= Some line }
        | _ -> result
      in
      let result =
        match List.assoc_opt "column" end_info with
        | Some (`Int column) -> { result with end_column= Some column }
        | _ -> result
      in
      result
    | _ -> result
  in
  result

let extract_name yojson =
  match List.assoc_opt "name" yojson with
  | Some (`String name) -> Some name
  | _ -> None

let extract_qual_names yojson =
  match List.assoc_opt "qual_name" yojson with
  | Some (`List qual_name) ->
    qual_name
    |> List.map (function
      | `String name -> [name]
      | _ -> []
    )
    |> List.flatten
  | _ -> []

let extract_type_ptr yojson =
  match List.assoc_opt "type_ptr" yojson with
  | Some (`Int ptr) -> Some ptr
  | _ -> None

let extract_desugared_type yojson =
  match List.assoc_opt "desugared_type" yojson with
  | Some (`Int ptr) -> Some ptr
  | _ -> None

let make_typedef_typemap typemap definitions =
  let parse_fields fields_yojson = List.fold_left (fun fields -> function
    | `Variant (
      "FieldDecl", Some (`Tuple (
        `Assoc _metadata ::
        `Assoc namedata ::
        `Assoc typedata ::
        _
        ))
      ) ->
        let ptr = extract_type_ptr typedata in
        let name = extract_name namedata in
        begin match ptr, name with
        | (Some ptr), (Some name) ->
          { ptr; name } :: fields
        | _ ->
          fields
        end
    | _ ->
      fields
    )
    []
    fields_yojson
  in
  List.fold_left (fun map -> function
  | `Variant (
    "RecordDecl", Some (`Tuple (
      `Assoc metadata ::
      `Assoc namedata ::
      `Int _type_ptr ::
      `List fields ::
      _ :: (* empty? *)
      _ :: (* ex. <"TTK_Struct"> *)
      `Assoc _definition_data ::
      _
      ))
    ) ->
    let ptr = extract_pointer metadata in
    let location = extract_location metadata in
    let qual_names = extract_qual_names namedata in
    let name =
      let rec go = function
        | name :: [] -> Some name
        | _ :: tail -> go tail
        | [] -> None
      in
      go qual_names
    in
    let fields = parse_fields fields in
    begin match ptr, name with
    | (Some ptr), (Some name) ->
      PointerMap.add ptr (Record { name; fields; location }) map
    | _ ->
      map
    end
  | _ ->
    map
  )
  typemap
  definitions

let make_typemap typemap typedata = List.fold_left (fun map -> function
  | `Variant (
    "BuiltinType", Some (`Tuple (
      `Assoc [("pointer", `Int i)] ::
      `Variant ((
        "Bool" |
        "Char_S" | "SChar" | "UChar" |
        "Short" | "UShort" |
        "Int" | "UInt" |
        "Long" | "ULong" | 
        "LongLong" | "ULongLong" |
        "Float" |
        "Double"
      ) as tpe, None) ::
      _
    ))
  ) as yojson ->
    let tpe = match tpe with
    | "Bool"  -> Ast.Tbool
    | "Char_S" -> Ast.Tchar_s
    | "SChar" -> Ast.Tchar
    | "UChar" -> Ast.Tuchar
    | "Short" -> Ast.Tshort
    | "UShort" -> Ast.Tushort
    | "Int" -> Ast.Tint
    | "UInt" -> Ast.Tuint
    | "Long" -> Ast.Tlong
    | "ULong" -> Ast.Tulong
    | "LongLong" -> Ast.Tlonglong
    | "ULongLong" -> Ast.Tulonglong
    | "Float" -> Ast.Tfloat
    | "Double" -> Ast.Tdouble
    | _ -> raise (Invalid_Yojson ("Invalid buildin type.", yojson))
    in
    PointerMap.add i (Just tpe) map
  | `Variant (
    "BuiltinType", Some (`Tuple (
      `Assoc [("pointer", `Int i)] ::
      `Variant ("Void", None) ::
      _
    ))
  ) ->
    PointerMap.add i (Just Ast.Tvoid) map
  (* in 'small C', we do not treat pointer type. *)
  (* | `Variant (
    "PointerType", Some (`Tuple (
      `Assoc [("pointer", `Int i)] ::
      `Assoc [("type_ptr", `Int p)] ::
      _
    ))
  ) ->
    PointerMap.add i (Pointer p) map *)
  | `Variant (
    "ConstantArrayType", Some (`Tuple (
      `Assoc [("pointer", `Int i)] ::
      `Assoc [
        ("element_type", `Assoc [("type_ptr", `Int p)]);
        _stride
      ] ::
      (`Int size) ::
      _
    ))
  ) ->
    PointerMap.add i (Array { ptr= p; size }) map
  | `Variant (
    "RecordType", Some (`Tuple (
      `Assoc pointer_data ::
      `Int ptr ::
      _
    ))
  ) ->
    begin match extract_pointer pointer_data with
    | Some i -> PointerMap.add i (Alias ptr) map
    | _ -> map
    end
  | `Variant (
    "ElaboratedType", Some (`Tuple (
      `Assoc pointer_data ::
      _
    ))
  ) ->
    let ptr = extract_pointer pointer_data in
    let desugared = extract_desugared_type pointer_data in
    begin match ptr, desugared with
    | (Some i), (Some ptr) -> PointerMap.add i (Alias ptr) map
    | _ -> map
    end
  | `Variant (
    "TypedefType", Some (`Tuple (
      `Assoc pointer_data ::
      `Assoc _typedata ::
      _
    ))
  ) ->
    let ptr = extract_pointer pointer_data in
    let desugared = extract_desugared_type pointer_data in
    begin match ptr, desugared with
    | (Some i), (Some ptr) -> PointerMap.add i (Alias ptr) map
    | _ -> map
    end
  | _ ->
    map
  )
  typemap
  typedata

let show_record_field { ptr; name } = name ^ "->" ^ string_of_int ptr

let show_c_type = function
  | Just tpe -> Ast.show_ctype tpe
  | Alias ptr -> "Alias->" ^ string_of_int ptr
  | Pointer p -> "Pointer->" ^ string_of_int p
  | Array { ptr; size } -> "Array[" ^ string_of_int size ^ "]->" ^ string_of_int ptr
  | Record { name; fields; _ } ->
    let fields =
      fields
      |> List.map (fun field -> "  " ^ show_record_field field)
      |> String.concat "\n"
    in
    "Struct " ^ name ^ " {\n" ^
    fields ^ "\n" ^
    "}"

let show_typemap typemap =
  typemap |> PointerMap.iter (fun idx tpe ->
    Printf.printf "%d => %s\n" idx (show_c_type tpe)
  )

type function_typeinfo = {
  return_type: c_type;
  param_types: c_type list
}

let parse_params_type typemap params_type yojson =
  match List.assoc_opt "params_type" params_type with
  | Some `List param_types ->
    param_types
    |> List.map (
      function
      | `Assoc[("type_ptr", `Int ptr)] ->
        begin match PointerMap.find_opt ptr typemap with
        | Some typ -> typ
        | None -> raise (Invalid_Yojson ("Type not found. ptr: " ^ string_of_int ptr, yojson))
        end
      | _ -> raise (Invalid_Yojson ("type_ptr not found", yojson))
    )
  | _ -> []

let make_fuction_typeinfo typemap typedata = List.fold_left (fun map -> function
  | `Variant (
    ("FunctionNoProtoType" | "FunctionProtoType"), Some (`Tuple (
      `Assoc [("pointer", `Int i)] ::
      `Assoc [("return_type", `Assoc [("type_ptr", `Int type_ptr)])] ::
      `Assoc params_type ::
      _
    ))
  ) as yojson ->
    let return_type =
      begin match PointerMap.find_opt type_ptr typemap with
      | Some typ -> typ
      | None -> raise (Invalid_Yojson ("Return type not found.", yojson))
      end
    in
    let param_types = parse_params_type typemap params_type yojson in
    PointerMap.add i { return_type; param_types } map
  | `Variant (
    ("FunctionNoProtoType" | "FunctionProtoType"), Some (`Tuple [
      `Assoc [("pointer", `Int i)];
      `Assoc [("return_type", `Assoc [("type_ptr", `Int type_ptr)])];
    ])
  ) as yojson ->
    let return_type =
      begin match PointerMap.find_opt type_ptr typemap with
      | Some typ -> typ
      | None -> raise (Invalid_Yojson ("Return type not found.", yojson))
      end
    in
    PointerMap.add i { return_type; param_types= [] } map
  | _ ->
    map
  )
  PointerMap.empty
  typedata

let show_fuction_typeinfo function_typeinfo =
  function_typeinfo |> PointerMap.iter (fun idx {return_type; param_types} ->
    let rt = show_c_type return_type in
    let at = param_types |> List.map show_c_type |> String.concat "," in
    Printf.printf "%d => { return: %s, args: %s }\n" idx rt at
  )

let parse_parameters typemap : Yojson.Safe.t -> Ast.single_name = function
  | `Variant (
    "ParmVarDecl", Some (`Tuple (
      `Assoc source_info ::
      `Assoc name_info ::
      `Assoc [("type_ptr", `Int type_ptr)] ::
      _
    ))
  ) as yojson ->
    let name =
      begin match List.assoc_opt "name" name_info with
      | Some (`String name) -> name
      | _ -> raise (Invalid_Yojson ("Paramater name not found.", yojson))
      end
    in
    let tpe =
      begin match find_type typemap type_ptr with
      | Some tpe -> tpe
      | None -> raise (Invalid_Yojson ("Paramater type not found.", yojson))
      end
    in
    tpe, name, extract_location source_info
  | yojson ->
    raise (Invalid_Yojson ("Invalid paramater data.", yojson))

let extract_variable_scope map =
  let get_scope scope =
    match List.assoc_opt scope map with
    | Some (`Bool true) -> true
    | _ -> false
  in
  Ast.{
    is_global= get_scope "is_global";
    is_static= get_scope "is_static";
    is_static_local= get_scope "is_static_local"
  }

let rec parse_expression typemap : Yojson.Safe.t -> Ast.expression = function
  | `Variant (
    "UnaryOperator", Some (`Tuple (
      `Assoc source_info ::
      `List [expr] ::
      _qual_type ::
      `Assoc (("kind", `Variant (kind, None)) :: _) ::
      _
    ))
  ) as yojson ->
    let expr = parse_expression typemap expr in
    let location = extract_location source_info in
    begin match kind with
    | "LNot" -> Ast.UNARY (Ast.NOT, expr, location)
    | "Minus" -> Ast.UNARY (Ast.MINUS, expr, location)
    | "PostInc" -> Ast.UNARY (Ast.POSINCR, expr, location)
    | "PreInc" -> Ast.UNARY (Ast.PREINCR, expr, location)
    | "PostDec" -> Ast.UNARY (Ast.POSDECR, expr, location)
    | "PreDec" -> Ast.UNARY (Ast.PREDECR, expr, location)
    | _ -> raise (Invalid_Yojson ("Invalid unary operation.", yojson))
    end
  | `Variant (
    "BinaryOperator", Some (`Tuple (
      `Assoc source_info ::
      `List [
        left_expr;
        right_expr;
      ] ::
      _qual_type ::
      `Assoc [("kind", `Variant (kind, None))] ::
      _
    ))
  ) as yojson ->
    let left = parse_expression typemap left_expr
    and right = parse_expression typemap right_expr
    in
    let location = extract_location source_info in
    begin match kind with
    | "Add" -> Ast.BINARY (Ast.ADD, left, right, location)
    | "Sub" -> Ast.BINARY (Ast.SUB, left, right, location)
    | "Mul" -> Ast.BINARY (Ast.MUL, left, right, location)
    | "Div" -> Ast.BINARY (Ast.DIV, left, right, location)
    | "Rem" -> Ast.BINARY (Ast.MOD, left, right, location)
    | "EQ" -> Ast.BINARY (Ast.EQ, left, right, location)
    | "NE" -> Ast.BINARY (Ast.NE, left, right, location)
    | "LT" -> Ast.BINARY (Ast.LT, left, right, location)
    | "LE" -> Ast.BINARY (Ast.LE, left, right, location)
    | "GT" -> Ast.BINARY (Ast.GT, left, right, location)
    | "GE" -> Ast.BINARY (Ast.GE, left, right, location)
    | "LAnd" -> Ast.BINARY (Ast.AND, left, right, location)
    | "LOr" -> Ast.BINARY (Ast.OR, left, right, location)
    | "Assign" -> Ast.BINARY (Ast.ASSIGN, left, right, location)
    | _ -> raise (Invalid_Yojson ("Invalid binary operation.", yojson))
    end
  (* We should care function call if and only if it is called with constant name. *)
  | `Variant (
    "CallExpr", Some (`Tuple (
      `Assoc source_info ::
      `List (
        `Variant (
          "ImplicitCastExpr", Some (`Tuple (
            _source_info2 ::
            `List [
              `Variant (
                "DeclRefExpr", Some (`Tuple (
                  _source_info3 ::
                  _body ::
                  _qual_type3 ::
                  `Assoc [("decl_ref", `Assoc [
                    ("kind", `Variant ("Function", None));
                    _decl_pointer;
                    ("name", `Assoc [
                      ("name", `String name);
                      _qual_name
                    ]);
                    _qual_type4;
                  ])] ::
                  _
                ))
              )
            ] ::
            _
          ))
        ) :: args
      ) ::
      _
    ))
  ) ->
    let args = List.map (parse_expression typemap) args in
    let location = extract_location source_info in
    Ast.CALL (name, args, location)
  | `Variant (
    "ParenExpr", Some (`Tuple (
      `Assoc source_info ::
      `List [expr] ::
      _
    ))
  ) ->
    Ast.PAREN (parse_expression typemap expr, extract_location source_info)
  | `Variant (
    "ImplicitCastExpr", Some (`Tuple (
      _source_info ::
      `List [expr] ::
      _
    ))
  ) ->
    parse_expression typemap expr
  | `Variant (
    "DeclRefExpr", Some (`Tuple (
      `Assoc source_info ::
      _children ::
      _qual_type ::
      `Assoc [("decl_ref", `Assoc decl_data)] ::
      _
    ))
  ) as yojson ->
    let name =
      begin match List.assoc_opt "name" decl_data with
      | Some (`Assoc name) ->
        begin match List.assoc_opt "name" name with
        | Some (`String name) -> name
        | _ -> raise (Invalid_Yojson ("Name data not found.", yojson))
        end
      | _ -> raise (Invalid_Yojson ("Name data not found.", yojson))
      end
    in
    let location = extract_location source_info in
    Ast.VARIABLE (name, location)
  | `Variant (
    "IntegerLiteral", Some (`Tuple (
      `Assoc source_info ::
      _children ::
      _qual_type ::
      `Assoc data ::
      _
    ))
  ) as yojson ->
    let value =
      begin match List.assoc_opt "value" data with
      | Some (`String value) -> value
      | _ -> raise (Invalid_Yojson ("Invalid expression data.", yojson))
      end
    in
    let location = extract_location source_info in
    Ast.CONSTANT (Ast.CONST_INT value, location)
  | `Variant (
    "ArraySubscriptExpr", Some (`Tuple (
      `Assoc source_info ::
      `List [
        arr;
        idx
      ] ::
      _
    ))
  ) ->
    Ast.INDEX (
      parse_expression typemap arr,
      parse_expression typemap idx,
      extract_location source_info
    )
  | `Variant (
    "MemberExpr", Some (`Tuple (
      `Assoc source_info ::
      `List (expr :: _) ::
      `Assoc _type_info ::
      `Assoc member_info ::
      _
    ))
  ) as yojson ->
    let expr = parse_expression typemap expr in
    let location = extract_location source_info in
    let name =
      let open Option.Let in
      let* name =
        match List.assoc_opt "name" member_info with
        | Some (`Assoc name) -> Some name
        | _ -> None
      in
      extract_name name
    in
    begin match name with
    | Some name ->
      Ast.MEMBER (expr, name, location)
    | None -> raise (Invalid_Yojson ("Invalid expression data. Member expression must have it's field name.", yojson))
    end
  | `Variant (
    "InitListExpr", Some (`Tuple (
      `Assoc source_info ::
      `List exprs ::
      `Assoc _type_info ::
      _
    ))
  ) ->
    let location = extract_location source_info in
    let exprs = List.map (parse_expression typemap) exprs in
    Ast.INIT_LIST (exprs, location)
  | yojson ->
    raise (Invalid_Yojson ("Invalid expression data.", yojson))

and parse_statement typemap : Yojson.Safe.t -> Ast.statement = function
  | `Variant (
    "DeclStmt", Some (`Tuple (
      `Assoc source_info ::
      _left_expressions ::
      `List var_decls ::
      _
    ))
  ) ->
    let stmts = var_decls |> List.map (parse_statement typemap) in
    let location = extract_location source_info in
    Ast.BLOCK (stmts, location)
  | `Variant (
    "VarDecl", Some (`Tuple (
      `Assoc source_info ::
      `Assoc varname_data ::
      `Assoc [("type_ptr", `Int type_ptr)] ::
      `Assoc var_info ::
      _
    ))
  ) as yojson ->
    let name =
      begin match List.assoc_opt "name" varname_data with
      | Some (`String name) -> name
      | _ -> raise (Invalid_Yojson ("Variable name not found.", yojson))
      end
    in
    let tpe =
      begin match find_type typemap type_ptr with
      | Some tpe -> tpe
      | None -> raise (Invalid_Yojson ("Variable type not found.", yojson))
      end
    in
    let location = extract_location source_info in
    begin match List.assoc_opt "init_expr" var_info with
    | Some init_expr ->
      let init_expr = parse_expression typemap init_expr in
      Ast.VARDECL (
        (tpe, [name, Ast.SINGLE_INIT init_expr]),
        extract_variable_scope var_info,
        location
      )
    | None ->
      Ast.VARDECL (
        (tpe, [name, Ast.NO_INIT]),
        extract_variable_scope var_info,
        location
      )
    end
  | `Variant (
    "IfStmt", Some (`Tuple (
      `Assoc source_info ::
      `List body ::
      _
    ))
  ) as yojson ->
    let location = extract_location source_info in
    begin match body with
    | [cond; true_stmts; false_stmts] ->
      Ast.IF (
        parse_expression typemap cond,
        Ast.BLOCK (parse_body typemap true_stmts, location),
        Ast.BLOCK (parse_body typemap false_stmts, location),
        location
      )
    | [cond; true_stmts] ->
      Ast.IF (
        parse_expression typemap cond,
        Ast.BLOCK (parse_body typemap true_stmts, location),
        Ast.NOP,
        location
      )
    | _ -> raise (Invalid_Yojson ("Invalid IF statement.", yojson))
    end
  | `Variant (
    "ForStmt", Some (`Tuple (
      `Assoc source_info ::
      `List [
        expr1;
        _; (* What is it? *)
        expr2;
        expr3;
        stmts;
      ] ::
      _
    ))
  ) ->
    let location = extract_location source_info in
    Ast.FOR (
      parse_expression typemap expr1,
      parse_expression typemap expr2,
      parse_expression typemap expr3,
      Ast.BLOCK (parse_body typemap stmts, location),
      location
    )
  | `Variant (
    "WhileStmt", Some (`Tuple (
      `Assoc source_info ::
      `List [
        expr;
        stmts;
      ] ::
      _
    ))
  ) ->
    let expr = parse_expression typemap expr in
    let body = parse_body typemap stmts in
    let location = extract_location source_info in
    Ast.WHILE (expr, (Ast.BLOCK (body, location)), location)
  | `Variant (
    "ReturnStmt", Some (`Tuple (
      `Assoc source_info ::
      `List expr ::
      _
    ))
  ) as yojson ->
    let location = extract_location source_info in
    begin match expr with
    | [expr] -> Ast.RETURN (Some (parse_expression typemap expr), location)
    | [] -> Ast.RETURN (None, location)
    | _ -> raise (Invalid_Yojson ("Return statements has multiple expressions.", yojson))
    end
  | expr ->
    Ast.COMPUTATION (parse_expression typemap expr)

and parse_body typemap : Yojson.Safe.t -> Ast.block = function
  | `Variant (
    "CompoundStmt", Some (`Tuple (
      _source_info ::
      `List statements ::
      _
    ))
  ) ->
    statements |> List.map (parse_statement typemap)
  | yojson ->
    [parse_statement typemap yojson]

let ast_of_yojson typemap function_typeinfo definitions =
  let parse_definition definitions = function
    | `Variant (
      "VarDecl", Some (`Tuple (
        `Assoc source_info :: (* filename, line num, col num, &c. *)
        `Assoc name_data ::
        `Assoc [("type_ptr", `Int type_ptr)] ::
        `Assoc var_info ::
        _
      ))
    ) as yojson ->
      let location = extract_location source_info in
      let variable_scope = extract_variable_scope var_info in
      let name =
        begin match List.assoc_opt "name" name_data with
        | Some (`String name) -> name
        | _ -> raise (Invalid_Yojson ("Function name not found.", yojson))
        end
      in
      let tpe =
        begin match find_type typemap type_ptr with
        | Some tpe -> tpe
        | None -> raise (Invalid_Yojson ("Type not found.", yojson))
        end
      in
      begin match List.assoc_opt "init_expr" var_info with
      | Some init_expr ->
        let init_expr = parse_expression typemap init_expr in
        Ast.DECDEF (
          (tpe, [name, Ast.SINGLE_INIT init_expr]),
          variable_scope,
          location
        ) :: definitions
      | None ->
        Ast.DECDEF (
          (tpe, [name, Ast.NO_INIT]),
          variable_scope,
          location
        ) :: definitions
      end
    | `Variant (
      "FunctionDecl", Some (`Tuple (
        `Assoc source_info ::
        `Assoc name_data ::
        `Assoc [("type_ptr", `Int type_ptr)] ::
        `Assoc data ::
        _
      ))
    ) as yojson ->
        let name =
          begin match List.assoc_opt "name" name_data with
          | Some (`String name) -> name
          | _ -> raise (Invalid_Yojson ("Function name not found.", yojson))
          end
        in
        let location = extract_location source_info in
        let return_type =
          let tpe = 
            match PointerMap.find_opt type_ptr function_typeinfo with
            | Some { return_type; _ } -> return_type
            | None -> raise (Invalid_Yojson ("Function type not found.", yojson))
          in
          match resolve_ctype typemap tpe with
          | Some tpe -> tpe
          | None -> raise (Invalid_Yojson ("Function type not found.", yojson))
        in
        let single_name = return_type, name, location in
        let params =
          begin match List.assoc_opt "parameters" data with
          | Some `List params -> List.map (parse_parameters typemap) params
          | _ -> []
          end
        in
        begin match List.assoc_opt "body" data with
        | Some body ->
          let body = parse_body typemap body in
          Ast.FUNDEF (single_name, params, body, location) :: definitions
        | None ->
          Ast.FUNDEF (single_name, params, [], location) :: definitions
        end
    | _ ->
      definitions
  in
  definitions
  |> List.fold_left parse_definition []
  |> List.rev

let ast_of_yojson (fname:string) : Yojson.Safe.t -> Ast.file = function
  | `Variant (
      "TranslationUnitDecl", Some (`Tuple (
        _metadata :: (* ? *)
        `List decls ::
        _any :: (* This is empty. *)
        `Assoc data ::
        _
      ))
    ) as yojson ->
        let typedata =
          begin match List.assoc_opt "types" data with
          | Some (`List typedata) -> typedata
          | _ -> raise (Invalid_Yojson ("Type data not found.", yojson))
          end
        in
        let typemap = make_typedef_typemap PointerMap.empty decls in
        let typemap = make_typemap typemap typedata in
        (* For debbug *)
        show_typemap typemap;

        let function_typeinfo = make_fuction_typeinfo typemap typedata in
        (* For debbug *)
        show_fuction_typeinfo function_typeinfo;
        let definitions = ast_of_yojson typemap function_typeinfo decls in
        fname, definitions
  | yojson ->
    raise (Invalid_Yojson ("Invalid AST Yojson.", yojson))

let parse_yojson fname =
  let yojson = Yojson.Safe.from_file fname in
  try Ok (ast_of_yojson fname yojson) with
  | Invalid_Yojson (message, yojson) ->
    Error (Invalid_Yojson (message, yojson))
