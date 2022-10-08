open Util

exception Invalid_Yojson of string * Yojson.Safe.t

type ctype =
  | Just of Ast.CType.t
  | Array of int * int
  | Pointer of int
  | Alias of int

let show_ctype = function
  | Just tpe -> "Just " ^ Ast.show_ctype tpe
  | Array (ptr, size) -> "Array[" ^ string_of_int size ^ "]->" ^ string_of_int ptr
  | Pointer ptr -> "Pointer->" ^ string_of_int ptr
  | Alias i -> "Alias->" ^ string_of_int i

module PointerMap = Map.Make(Int)

let find_type typemap i = PointerMap.find_opt i typemap

let extract_pointer yojson =
  match List.assoc_opt "pointer" yojson with
  | Some (`Int ptr) -> Some ptr
  | _ -> None

let extract_location info =
  let result = Ast.Location.empty in
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
    | "Bool"  -> Ast.CType.Tbool
    | "Char_S" -> Ast.CType.Tchar_s
    | "SChar" -> Ast.CType.Tchar
    | "UChar" -> Ast.CType.Tuchar
    | "Short" -> Ast.CType.Tshort
    | "UShort" -> Ast.CType.Tushort
    | "Int" -> Ast.CType.Tint
    | "UInt" -> Ast.CType.Tuint
    | "Long" -> Ast.CType.Tlong
    | "ULong" -> Ast.CType.Tulong
    | "LongLong" -> Ast.CType.Tlonglong
    | "ULongLong" -> Ast.CType.Tulonglong
    | "Float" -> Ast.CType.Tfloat
    | "Double" -> Ast.CType.Tdouble
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
    PointerMap.add i (Just Ast.CType.Tvoid) map
  | `Variant (
    "PointerType", Some (`Tuple (
      `Assoc pointer_data ::
      `Assoc typedata ::
      _
    ))
  ) ->
    let info =
      let open Option.Let in
      let* ptr = extract_pointer pointer_data in
      let* type_ptr = extract_type_ptr typedata in
      Some ((ptr, type_ptr))
    in
    begin match info with
    | Some ((i, p)) ->
      PointerMap.add i (Pointer p) map
    | _ -> map
    end
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
    PointerMap.add i (Array (p, size)) map
  | `Variant (
    "RecordType", Some (`Tuple (
      `Assoc pointer_data ::
      `Int ptr ::
      _
    ))
  ) ->
    begin match extract_pointer pointer_data with
    | Some i -> PointerMap.add i (Just (Ast.CType.Tdefined ptr)) map
    | _ -> map
    end
  | `Variant (
    "EnumType", Some (`Tuple (
      `Assoc pointer_data ::
      `Int ptr ::
      _
    ))
  ) ->
    begin match extract_pointer pointer_data with
    | Some i -> PointerMap.add i (Just (Ast.CType.Tdefined ptr)) map
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
  | `Variant (
    "DecayedType", Some (`Tuple (
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

let show_ctype_map typemap =
  typemap |> PointerMap.iter (fun idx tpe ->
    Printf.printf "%d => %s\n" idx (show_ctype tpe)
  )

let reduce_ctype typemap =
  let rec reduce typemap key =
    let open Option.Let in
    let* tpe = PointerMap.find_opt key typemap in
    match tpe with
    | Just tpe ->
      Some (typemap, tpe)
    | Array (ptr, size) ->
      let* typemap, tpe = reduce typemap ptr in
      let tpe = Ast.CType.Tarray (tpe, size) in
      let typemap = PointerMap.add key (Just tpe) typemap in
      Some (typemap, tpe)
    | Pointer ptr ->
      let* typemap, tpe = reduce typemap ptr in
      let tpe = Ast.CType.Tpointer tpe in
      let typemap = PointerMap.add key (Just tpe) typemap in
      Some (typemap, tpe)
    | Alias ptr ->
      let* typemap, tpe = reduce typemap ptr in
      let typemap = PointerMap.add key (Just tpe) typemap in
      Some (typemap, tpe)
  in
  let _, result = PointerMap.fold (fun key _ (cache, acc) ->
    match reduce cache key with
    | Some (cache, tpe) ->
      let acc = PointerMap.add key tpe acc in
      cache, acc
    | None ->
      cache, acc
  ) typemap (typemap, PointerMap.empty) in
  result

let show_typemap typemap =
  typemap |> PointerMap.iter (fun idx tpe ->
    Printf.printf "%d => %s\n" idx (Ast.show_ctype tpe)
  )

type function_typeinfo = {
  return_type: Ast.CType.t;
  param_types: Ast.CType.t list
}

let parse_params_type typemap params_type yojson =
  match List.assoc_opt "params_type" params_type with
  | Some `List param_types ->
    param_types
    |> List.map (
      function
      | `Assoc type_info ->
        let ptr =
          match extract_type_ptr type_info with
          | Some ptr -> ptr
          | None -> raise (Invalid_Yojson ("Type not found. Cannot resolve type_ptr", yojson))
        in
        let tpe =
          match PointerMap.find_opt ptr typemap with
          | Some tpe -> tpe
          | None -> raise (Invalid_Yojson ("Type not found. ptr:" ^ string_of_int ptr, yojson))
        in
        tpe
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
    let rt = Ast.show_ctype return_type in
    let at = param_types |> List.map Ast.show_ctype |> String.concat "," in
    Printf.printf "%d => { return: %s, args: %s }\n" idx rt at
  )

let parse_parameters typemap : Yojson.Safe.t -> Ast.single_name = function
  | `Variant (
    "ParmVarDecl", Some (`Tuple (
      `Assoc source_info ::
      `Assoc name_info ::
      `Assoc typedata ::
      _
    ))
  ) as yojson ->
    let name =
      match List.assoc_opt "name" name_info with
      | Some (`String name) -> name
      | _ -> raise (Invalid_Yojson ("Paramater name not found.", yojson))
    in
    let tpe =
      match
        extract_type_ptr typedata
        |> Option.flat_map (find_type typemap)
      with
      | Some tpe -> tpe
      | None -> raise (Invalid_Yojson ("Paramater type not found.", yojson))
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
    "ConstantExpr", Some (`Tuple (
      `Assoc source_info ::
      `List [expr] ::
      _qual_type ::
      _
    ))
  ) ->
    let location = extract_location source_info in
    let expr = parse_expression typemap expr in
    Ast.CONST_EXPR (expr, location)
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
    | "Deref" -> Ast.UNARY (Ast.DEREF, expr, location)
    | "AddrOf" -> Ast.UNARY (Ast.ADDROF, expr, location)
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
    | "And" | "LAnd" -> Ast.BINARY (Ast.AND, left, right, location)
    | "Or" | "LOr" -> Ast.BINARY (Ast.OR, left, right, location)
    | "Assign" -> Ast.BINARY (Ast.ASSIGN, left, right, location)
    | _ -> raise (Invalid_Yojson ("Invalid binary operation.", yojson))
    end
  | `Variant (
    "ConditionalOperator", Some (`Tuple (
      `Assoc source_info ::
      (* It is sufficient to deal only with cases where there are strictly three arguments. *)
      ` List [ cond; lhs; rhs ] ::
      `Assoc _type_info ::
      _
    ))
  ) ->
    let location = extract_location source_info in
    let cond = parse_expression typemap cond in
    let lhs = parse_expression typemap lhs in
    let rhs = parse_expression typemap rhs in
    Ast.CONDITIONAL (cond, lhs, rhs, location)
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
    ("ImplicitCastExpr" | "CStyleCastExpr"), Some (`Tuple (
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
    "FloatingLiteral", Some (`Tuple (
      `Assoc source_info ::
      _children ::
      _qual_type ::
      `String value ::
      _
    ))
  ) ->
    let location = extract_location source_info in
    Ast.CONSTANT (Ast.CONST_FLOAT value, location)
  | `Variant (
    "CharacterLiteral", Some (`Tuple (
      `Assoc source_info ::
      _children ::
      _qual_type ::
      `Int value ::
      _
    ))
  ) ->
    let location = extract_location source_info in
    Ast.CONSTANT (Ast.CONST_CHAR (string_of_int value), location)
  | `Variant (
    "StringLiteral", Some (`Tuple (
      `Assoc source_info ::
      _children ::
      _qual_type ::
      `List [`String value] ::
      _
    ))
  ) ->
    let location = extract_location source_info in
    Ast.CONSTANT (Ast.CONST_STRING value, location)
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

and parse_record_or_union typemap yojson =
  let parse_fields fields_yojson = List.fold_left (fun fields -> function
    | `Variant (
      "FieldDecl", Some (`Tuple (
        `Assoc _metadata ::
        `Assoc namedata ::
        `Assoc typedata ::
        `Assoc bit_width_expr_data ::
        _
        ))
      ) ->
        let ctype = typedata
          |> extract_type_ptr
          |> Option.flat_map (fun ptr -> PointerMap.find_opt ptr typemap)
        in
        let name = extract_name namedata in
        begin match ctype, name with
        | (Some field_type), (Some field_name) ->
          let bit_width_expr = bit_width_expr_data
            |> List.assoc_opt "bit_width_expr" 
            |> Option.map (parse_expression typemap)
          in
          Ast.{ field_type; field_name; bit_width_expr } :: fields
        | _ ->
          fields
        end
    | _ ->
      fields
    )
    []
    fields_yojson
  in
  match yojson with
  | `Variant (
    "RecordDecl", Some (`Tuple (
      `Assoc metadata ::
      `Assoc namedata ::
      `Int _type_ptr ::
      `List fields ::
      _ :: (* empty? *)
      struct_or_union :: (* <"TTK_Struct"> or <"TTK_Union"> *)
      `Assoc _definition_data ::
      _
      ))
    ) ->
      let ptr = extract_pointer metadata in
      let location = extract_location metadata in
      let qual_names = extract_qual_names namedata in
      let name =
        let rec loop = function
          | name :: [] -> Some name
          | name :: tail -> Option.map (fun name' -> name' ^ "." ^ name) @@ loop tail
          | [] -> None
        in
        loop qual_names
      in
      let fields = parse_fields fields in
      begin match ptr, name with
      | (Some ptr), (Some name) ->
        begin match struct_or_union with
        | `Variant ("TTK_Struct", _) ->
          let record = Ast.{ record_name= name; record_fields= fields } in
          `TTK_Struct (ptr, record, location)
        | `Variant ("TTK_Union", _) ->
          let union = Ast.{ union_name= name; union_fields= fields } in
          `TTK_Union (ptr, union, location)
        | _ ->
          raise (Invalid_Yojson ("Invalid record definition.", yojson))
        end
      | _ ->
        raise (Invalid_Yojson ("Invalid record definition.", yojson))
      end
  | _ -> raise (Invalid_Yojson ("Invalid record definition.", yojson))

and parse_enum typemap yojson =
  let parse_enumerators enumerators_yojson = List.fold_left (fun enumerators -> function
    | `Variant (
      "EnumConstantDecl", Some (`Tuple(
        `Assoc _metadata ::
        `Assoc namedata ::
        `Assoc typedata ::
        `Assoc init_expr ::
        _
      ))
    ) ->
      let ctype = typedata
        |> extract_type_ptr
        |> Option.flat_map (fun ptr -> PointerMap.find_opt ptr typemap)
      in
      let name = extract_name namedata in
      begin match ctype, name with
      | (Some enumerator_type), (Some enumerator_name) ->
        let init_expr = init_expr
          |> List.assoc_opt "init_expr" 
          |> Option.map (parse_expression typemap)
        in
        Ast.{ enumerator_type; enumerator_name; init_expr } :: enumerators
      | _ ->
        enumerators
      end
    | _ ->
      enumerators
    )
    []
    enumerators_yojson
  in
  match yojson with
  | `Variant (
    "EnumDecl", Some (`Tuple (
      `Assoc metadata ::
      `Assoc namedata ::
      _ ::
      `List enumerators ::
      _ :: (* empty? *)
      _ :: (* TTK_Enum *)
      _ :: (* empty? *)
      _
    ))
  ) ->
    let ptr = extract_pointer metadata in
    let location = extract_location metadata in
    let qual_names = extract_qual_names namedata in
    let name =
      let rec loop = function
        | name :: [] -> Some name
        | name :: tail -> Option.map (fun name' -> name' ^ "." ^ name) @@ loop tail
        | [] -> None
      in
      loop qual_names
    in
    let enumerators = parse_enumerators enumerators in
    begin match ptr, name with
    | (Some ptr), (Some enum_name) ->
      let enum = Ast.{ enum_name; enumerators } in
      ptr, enum, location      
    | _ -> raise (Invalid_Yojson ("Invalid record definition.", yojson))
    end
  | _ -> raise (Invalid_Yojson ("Invalid record definition.", yojson))

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
  | `Variant ("RecordDecl", _) as yojson ->
    begin match parse_record_or_union typemap yojson with
    | `TTK_Struct (id, record, location) -> Ast.RECORDDEC (id, record, location)
    | `TTK_Union (id, union, location) -> Ast.UNIONDEC (id, union, location)
    end
  | `Variant ("EnumDecl", _) as yojson ->
    let id, enum, location = parse_enum typemap yojson in
    Ast.ENUMDEC (id, enum, location)
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
          match PointerMap.find_opt type_ptr function_typeinfo with
          | Some { return_type; _ } -> return_type
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
    | `Variant ("RecordDecl", _) as yojson ->
      begin match parse_record_or_union typemap yojson with
      | `TTK_Struct (id, record, location) -> Ast.RECORDDEF (id, record, location) :: definitions
      | `TTK_Union (id, union, location) -> Ast.UNIONDEF (id, union, location) :: definitions
      end
    | `Variant ("EnumDecl", _) as yojson ->
      let id, enum, location = parse_enum typemap yojson in
      Ast.ENUMDEF (id, enum, location) :: definitions
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
        let typemap = make_typemap PointerMap.empty typedata in
        (* For debbug *)
        Printf.printf "Show raw typemap\n";
        show_ctype_map typemap;
        let typemap = reduce_ctype typemap in
        (* For debbug *)
        Printf.printf "Show typemap\n";
        show_typemap typemap;

        let function_typeinfo = make_fuction_typeinfo typemap typedata in
        (* For debbug *)
        Printf.printf "Show function typeinfo\n";
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
