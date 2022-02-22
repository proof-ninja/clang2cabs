exception Invalid_Yojson of string * Yojson.Safe.t

type c_type =
  | Just of Ast.type_specifier
  | Pointer of int

module PointerMap = Map.Make(Int)

let find_type typemap i =
  let rec impl p =
    match PointerMap.find_opt p typemap with
    | Some (Just tpe) -> Some (tpe, Ast.JUSTBASE)
    | Some (Pointer p) ->
      begin match impl p with
      | Some (tpe, decl_type) -> Some (tpe, Ast.ARRAY decl_type)
      | None -> None
      end
    | None -> None
  in
  impl i

let make_typemap typedata = List.fold_left (fun map -> function
  | `Variant (
    "BuiltinType", Some (`Tuple (
      `Assoc [("pointer", `Int i)] ::
      `Variant ("Int", None) ::
      _
    ))
  ) ->
    PointerMap.add i (Just Ast.Tint) map
  | `Variant (
    "BuiltinType", Some (`Tuple (
      `Assoc [("pointer", `Int i)] ::
      `Variant ("Void", None) ::
      _
    ))
  ) ->
    PointerMap.add i (Just Ast.Tvoid) map
  | `Variant (
    "PointerType", Some (`Tuple (
      `Assoc [("pointer", `Int i)] ::
      `Assoc [("type_ptr", `Int p)] ::
      _
    ))
  ) ->
    PointerMap.add i (Pointer p) map
  | `Variant (
    "ConstantArrayType", Some (`Tuple (
      `Assoc [("pointer", `Int i)] ::
      `Assoc [
        ("element_type", `Assoc [("type_ptr", `Int p)]);
        _stride
      ] ::
      _
    ))
  ) ->
    PointerMap.add i (Pointer p) map
  | _ ->
    map
  )
  PointerMap.empty
  typedata

let show_c_type = function
  | Just tpe -> Ast.show_type_specifier tpe
  | Pointer p -> "Pointer->" ^ string_of_int p

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
        | None -> raise (Invalid_Yojson ("Type not found", yojson))
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
      _source_info ::
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
    [tpe], (name, decl_type)
  | yojson ->
    raise (Invalid_Yojson ("Invalid paramater data.", yojson))

let rec parse_expression typemap : Yojson.Safe.t -> Ast.expression = function
  | `Variant (
    "UnaryOperator", Some (`Tuple (
      _source_info ::
      `List [expr] ::
      _qual_type ::
      `Assoc (("kind", `Variant (kind, None)) :: _) ::
      _
    ))
  ) as yojson ->
    let expr = parse_expression typemap expr in
    begin match kind with
    | "LNot" -> Ast.UNARY (Ast.NOT, expr)
    | "Minus" -> Ast.UNARY (Ast.MINUS, expr)
    | "PostInc" -> Ast.UNARY (Ast.POSINCR, expr)
    | "PreInc" -> Ast.UNARY (Ast.PREINCR, expr)
    | "PostDec" -> Ast.UNARY (Ast.POSDECR, expr)
    | "PreDec" -> Ast.UNARY (Ast.PREDECR, expr)
    | _ -> raise (Invalid_Yojson ("Invalid unary operation.", yojson))
    end
  | `Variant (
    "BinaryOperator", Some (`Tuple (
      _source_info ::
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
    begin match kind with
    | "Add" -> Ast.BINARY (Ast.ADD, left, right)
    | "Sub" -> Ast.BINARY (Ast.SUB, left, right)
    | "Mul" -> Ast.BINARY (Ast.MUL, left, right)
    | "Div" -> Ast.BINARY (Ast.DIV, left, right)
    | "Rem" -> Ast.BINARY (Ast.MOD, left, right)
    | "EQ" -> Ast.BINARY (Ast.EQ, left, right)
    | "NE" -> Ast.BINARY (Ast.NE, left, right)
    | "LT" -> Ast.BINARY (Ast.LT, left, right)
    | "LE" -> Ast.BINARY (Ast.LE, left, right)
    | "GT" -> Ast.BINARY (Ast.GT, left, right)
    | "GE" -> Ast.BINARY (Ast.GE, left, right)
    | "LAnd" -> Ast.BINARY (Ast.AND, left, right)
    | "LOr" -> Ast.BINARY (Ast.OR, left, right)
    | "Assign" -> Ast.BINARY (Ast.ASSIGN, left, right)
    | _ -> raise (Invalid_Yojson ("Invalid binary operation.", yojson))
    end
  (* We should care function call if and only if it is called with constant name. *)
  | `Variant (
    "CallExpr", Some (`Tuple (
      _source_info ::
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
    Ast.CALL (name, args)
  | `Variant (
    "ParenExpr", Some (`Tuple (
      _source_info ::
      `List [expr] ::
      _
    ))
  ) ->
    Ast.PAREN (parse_expression typemap expr)
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
      _source_info ::
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
    Ast.VARIABLE name
  | `Variant (
    "IntegerLiteral", Some (`Tuple (
      _source_info ::
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
    Ast.CONSTANT (Ast.CONST_INT value)
  | `Variant (
    "ArraySubscriptExpr", Some (`Tuple (
      _source_info ::
      `List [
        arr;
        idx
      ] ::
      _
    ))
  ) ->
    Ast.INDEX (
      parse_expression typemap arr,
      parse_expression typemap idx
    )
  | yojson ->
    raise (Invalid_Yojson ("Invalid expression data.", yojson))

and parse_statement typemap : Yojson.Safe.t -> Ast.statement = function
  | `Variant (
    "DeclStmt", Some (`Tuple (
      _source_info ::
      _left_expressions ::
      `List var_decls ::
      _
    ))
  ) ->
    Ast.BLOCK (var_decls |> List.map (parse_statement typemap))
  | `Variant (
    "VarDecl", Some (`Tuple (
      _source_info ::
      `Assoc varname_data ::
      `Assoc [("type_ptr", `Int type_ptr)] ::
      `Assoc init_expr ::
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
    begin match List.assoc_opt "init_expr" init_expr with
    | Some init_expr ->
      let init_expr = parse_expression typemap init_expr in
      Ast.VARDECL ([tpe], [(name, decl_type), Ast.SINGLE_INIT init_expr])
    | None ->
      Ast.VARDECL ([tpe], [(name, decl_type), Ast.NO_INIT])
    end
  | `Variant (
    "IfStmt", Some (`Tuple (
      _source_info ::
      `List body ::
      _
    ))
  ) as yojson ->
    begin match body with
    | [cond; true_stmts; false_stmts] ->
      Ast.IF (
        parse_expression typemap cond,
        Ast.BLOCK (parse_body typemap true_stmts),
        Ast.BLOCK (parse_body typemap false_stmts)
      )
    | [cond; true_stmts] ->
      Ast.IF (
        parse_expression typemap cond,
        Ast.BLOCK (parse_body typemap true_stmts),
        Ast.NOP
      )
    | _ -> raise (Invalid_Yojson ("Invalid IF statement.", yojson))
    end
  | `Variant (
    "ForStmt", Some (`Tuple (
      _source_info ::
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
    Ast.FOR (
      parse_expression typemap expr1,
      parse_expression typemap expr2,
      parse_expression typemap expr3,
      Ast.BLOCK (parse_body typemap stmts)
    )
  | `Variant (
    "WhileStmt", Some (`Tuple (
      _source_info ::
      `List [
        expr;
        stmts;
      ] ::
      _
    ))
  ) ->
    let expr = parse_expression typemap expr in
    let body = parse_body typemap stmts in
    Ast.WHILE (expr, Ast.BLOCK body)
  | `Variant (
    "ReturnStmt", Some (`Tuple (
      _source_info ::
      `List expr ::
      _
    ))
  ) as yojson ->
    begin match expr with
    | [expr] -> Ast.RETURN (Some (parse_expression typemap expr))
    | [] -> Ast.RETURN None
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
        _metadata :: (* filename, line num, col num, &c. *)
        `Assoc name_data ::
        `Assoc [("type_ptr", `Int type_ptr)] ::
        `Assoc [("is_global", `Bool _is_global)] ::
        _
      ))
    ) as yojson ->
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
      Ast.DECDEF ([tpe], [((name, decl_type), Ast.NO_INIT)]) :: definitions
    | `Variant (
      "FunctionDecl", Some (`Tuple (
        _metadata :: (* filename, line num, col num, &c. *)
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
        let return_type, decl_type =
          begin match PointerMap.find_opt type_ptr function_typeinfo with
          | Some { return_type; _ } ->
            begin match return_type with
            | Just tpe -> tpe, Ast.JUSTBASE
            | Pointer i ->
              match find_type typemap i with
              | Some (tpe, decl_type) -> tpe, (Ast.ARRAY decl_type)
              | None -> raise (Invalid_Yojson ("Function type not found.", yojson))
            end
          | None -> raise (Invalid_Yojson ("Function type not found.", yojson))
          end
        in
        let single_name = [return_type], (name, decl_type) in
        let params =
          begin match List.assoc_opt "parameters" data with
          | Some `List params -> List.map (parse_parameters typemap) params
          | _ -> []
          end
        in
        let body =
          begin match List.assoc_opt "body" data with
          | Some body -> parse_body typemap body
          | None -> raise (Invalid_Yojson ("Body not found.", yojson))
          end
        in
        Ast.FUNDEF (single_name, params, body) :: definitions
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
