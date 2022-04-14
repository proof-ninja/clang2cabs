open Util

exception Invalid_Yojson of string * Yojson.Safe.t

type [@warning "-37"] c_type =
  | Just of Ast.ctype
  | Pointer of int
  | Array of { ptr: int; size: int }

module PointerMap = Map.Make(Int)

let find_type typemap i =
  let rec impl p =
    match PointerMap.find_opt p typemap with
    | Some (Just tpe) -> Some (tpe, Ast.JUSTBASE)
    | Some (Pointer ptr) ->
      begin match impl ptr with
      | Some (tpe, decl_type) ->
        Some (tpe, Ast.PTR decl_type)
      | None -> None
      end
    | Some (Array { ptr; size }) ->
      begin match impl ptr with
      | Some (tpe, decl_type) ->
        let expr = Ast.CONSTANT (Ast.CONST_INT (string_of_int size), Ast.empty_location) in
        Some (tpe, Ast.ARRAY (decl_type, expr))
      | None -> None
      end
    | None -> None
  in
  impl i

let make_typemap typedata = List.fold_left (fun map -> function
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
  | _ ->
    map
  )
  PointerMap.empty
  typedata

let show_c_type = function
  | Just tpe -> Ast.show_ctype tpe
  | Pointer p -> "Pointer->" ^ string_of_int p
  | Array { ptr; size } -> "Array[" ^ string_of_int size ^ "]->" ^ string_of_int ptr

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
    let tpe, decl_type =
      begin match find_type typemap type_ptr with
      | Some (tpe, decl_type) -> tpe, decl_type
      | None -> raise (Invalid_Yojson ("Paramater type not found.", yojson))
      end
    in
    tpe, (name, decl_type), extract_location source_info
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
    let tpe, decl_type =
      begin match find_type typemap type_ptr with
      | Some (tpe, decl_type) -> tpe, decl_type
      | None -> raise (Invalid_Yojson ("Variable type not found.", yojson))
      end
    in
    let location = extract_location source_info in
    begin match List.assoc_opt "init_expr" var_info with
    | Some init_expr ->
      let init_expr = parse_expression typemap init_expr in
      Ast.VARDECL (
        (tpe, [(name, decl_type), Ast.SINGLE_INIT init_expr]),
        extract_variable_scope var_info,
        location
      )
    | None ->
      Ast.VARDECL (
        (tpe, [(name, decl_type), Ast.NO_INIT]),
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
      let tpe, decl_type =
        begin match find_type typemap type_ptr with
        | Some (tpe, decl_type) -> tpe, decl_type
        | None -> raise (Invalid_Yojson ("Type not found.", yojson))
        end
      in
      begin match List.assoc_opt "init_expr" var_info with
      | Some init_expr ->
        let init_expr = parse_expression typemap init_expr in
        Ast.DECDEF (
          (tpe, [(name, decl_type), Ast.SINGLE_INIT init_expr]),
          variable_scope,
          location
        ) :: definitions
      | None ->
        Ast.DECDEF (
          (tpe, [(name, decl_type), Ast.NO_INIT]),
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
        let return_type, decl_type =
          begin match PointerMap.find_opt type_ptr function_typeinfo with
          | Some { return_type; _ } ->
            begin match return_type with
            | Just tpe -> tpe, Ast.JUSTBASE
            | Array { ptr; size} ->
              begin match find_type typemap ptr with
              | Some (tpe, decl_type) ->
                let expr = Ast.CONSTANT (Ast.CONST_INT (string_of_int size), location) in
                tpe, (Ast.ARRAY (decl_type, expr))
              | None -> raise (Invalid_Yojson ("Function type not found.", yojson))
              end
            | Pointer i ->
              match find_type typemap i with
              | Some (tpe, decl_type) -> tpe, (Ast.PTR decl_type)
              | None -> raise (Invalid_Yojson ("Function type not found.", yojson))
            end
          | None -> raise (Invalid_Yojson ("Function type not found.", yojson))
          end
        in
        let single_name = return_type, (name, decl_type), location in
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
        let typemap = make_typemap typedata in
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
