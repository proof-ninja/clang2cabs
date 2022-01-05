exception Invalid_Yojson of string * Yojson.Safe.t

module PointerMap = Map.Make(Int)

let rec make_typemap map: Yojson.Safe.t list -> Ast.type_specifier PointerMap.t = function
  | `Variant (
    "BuiltinType", Some (`Tuple [
      `Assoc [("pointer", `Int i)];
      `Variant ("Int", None)
    ])
  ) :: rest ->
    make_typemap
      (PointerMap.add i Ast.Tint map)
      rest
  | `Variant (
    "BuiltinType", Some (`Tuple [
      `Assoc [("pointer", `Int i)];
      `Variant ("Void", None)
    ])
  ) :: rest ->
    make_typemap
      (PointerMap.add i Ast.Tvoid map)
      rest
  | _ :: rest ->
    make_typemap map rest
  | [] ->
    map

let make_typemap typedata = make_typemap PointerMap.empty typedata

let show_typemap typemap =
  typemap |> PointerMap.iter (fun idx tpe ->
    Printf.printf "%d => %s\n" idx (Ast.show_type_specifier tpe)
  )

type function_typeinfo = {
  return_type : Ast.type_specifier;
  param_types: Ast.type_specifier list
}

let rec make_fuction_typeinfo typemap map : Yojson.Safe.t list -> function_typeinfo PointerMap.t = function
  | `Variant (
    "FunctionNoProtoType", Some (`Tuple [
      `Assoc [("pointer", `Int i)];
      `Assoc [("return_type", `Assoc [("type_ptr", `Int type_ptr)])]
    ])
  ) as yojson :: rest ->
    let return_type =
      begin match PointerMap.find_opt type_ptr typemap with
      | Some typ -> typ
      | None -> raise (Invalid_Yojson ("Return type not found.", yojson))
      end
    in
    make_fuction_typeinfo typemap (PointerMap.add i { return_type; param_types= [] } map) rest
  | `Variant (
    "FunctionProtoType", Some (`Tuple [
      `Assoc [("pointer", `Int i)];
      `Assoc [("return_type", `Assoc [("type_ptr", `Int type_ptr)])];
      `Assoc [("params_type", `List param_types)]
    ])
  ) as yojson :: rest ->
    let return_type =
      begin match PointerMap.find_opt type_ptr typemap with
      | Some typ -> typ
      | None -> raise (Invalid_Yojson ("Return type not found.", yojson))
      end
    in
    let param_types =
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
    in
    make_fuction_typeinfo typemap (PointerMap.add i { return_type; param_types } map) rest
  | _ :: rest ->
    make_fuction_typeinfo typemap map rest
  | [] ->
    map

let make_fuction_typeinfo typemap typedata = make_fuction_typeinfo typemap PointerMap.empty typedata

let show_fuction_typeinfo function_typeinfo =
  function_typeinfo |> PointerMap.iter (fun idx {return_type; param_types} ->
    let rt = Ast.show_type_specifier return_type in
    let at = param_types |> List.map Ast.show_type_specifier |> String.concat "," in
    Printf.printf "%d => { return: %s, args: %s }\n" idx rt at
  )

let parse_parameters typemap : Yojson.Safe.t -> Ast.single_name = function
  | `Variant (
    "ParmVarDecl", Some (`Tuple [
      _source_info;
      `Assoc name_info;
      `Assoc [("type_ptr", `Int type_ptr)];
      _index_info
    ])
  ) as yojson ->
    let name =
      begin match List.assoc_opt "name" name_info with
      | Some (`String name) -> name
      | _ -> raise (Invalid_Yojson ("Paramater name not found.", yojson))
      end
    in
    let tpe =
      begin match PointerMap.find_opt type_ptr typemap with
      | Some tpe -> tpe
      | _ -> raise (Invalid_Yojson ("Paramater type not found.", yojson))
      end
    in
    [tpe], name
  | yojson ->
    raise (Invalid_Yojson ("Invalid paramater data.", yojson))

let rec parse_expression typemap : Yojson.Safe.t -> Ast.expression = function
| `Variant (
  "BinaryOperator", Some (`Tuple [
    _source_info;
    `List [
      left_expr;
      right_expr;
    ];
    _qual_type;
    `Assoc [("kind", `Variant (kind, None))]
  ])
) as yojson ->
  let left = parse_expression typemap left_expr
  and right = parse_expression typemap right_expr
  in
  begin match kind with
  | "Add" -> Ast.BINARY (Ast.ADD, left, right)
  | _ -> raise (Invalid_Yojson ("Invalid expression data.", yojson))
  end
| `Variant (
  "ImplicitCastExpr", Some (`Tuple [
    _source_info;
    `List [expr];
    _qual_type;
    _cast_kind;
    _flag (* ? *)
  ])
) ->
  parse_expression typemap expr
| `Variant (
  "DeclRefExpr", Some (`Tuple [
    _source_info;
    _children;
    _qual_type;
    `Assoc [("decl_ref", `Assoc decl_data)]
  ])
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
  "IntegerLiteral", Some (`Tuple [
    _source_info;
    _children;
    _qual_type;
    `Assoc data
  ])
) as yojson ->
  let value =
    begin match List.assoc_opt "value" data with
    | Some (`String value) -> value
    | _ -> raise (Invalid_Yojson ("Invalid expression data.", yojson))
    end
  in
  Ast.CONSTANT (Ast.CONST_INT value)
| yojson ->
  raise (Invalid_Yojson ("Invalid expression data.", yojson))
and parse_statement typemap : Yojson.Safe.t -> Ast.statement = function
  | `Variant (
    "DeclStmt", Some (`Tuple [
      _source_info;
      _left_expressions;
      `List var_decls
    ])
  ) ->
    Ast.BLOCK (var_decls |> List.map (parse_statement typemap))
  | `Variant (
    "VarDecl", Some (`Tuple [
      _source_info;
      `Assoc varname_data;
      `Assoc [("type_ptr", `Int type_ptr)];
      `Assoc init_expr
    ])
  ) as yojson ->
    let name =
      begin match List.assoc_opt "name" varname_data with
      | Some (`String name) -> name
      | _ -> raise (Invalid_Yojson ("Variable name not found.", yojson))
      end
    in
    let tpe =
      begin match PointerMap.find_opt type_ptr typemap with
      | Some tpe -> tpe
      | None -> raise (Invalid_Yojson ("Variable type not found.", yojson))
      end
    in
    begin match List.assoc_opt "init_expr" init_expr with
    | Some init_expr ->
      let init_expr = parse_expression typemap init_expr in
      Ast.VARDECL ([tpe], [(name, Ast.JUSTBASE), Ast.SINGLE_INIT init_expr])
    | None ->
      Ast.VARDECL ([tpe], [(name, Ast.JUSTBASE), Ast.NO_INIT])
    end
  | `Variant (
    "ReturnStmt", Some (`Tuple [
      _source_info;
      `List [expr]
    ])
  ) ->
    Ast.RETURN (parse_expression typemap expr)
  | yojson ->
    raise (Invalid_Yojson ("Invalid statement data.", yojson))

and parse_body typemap : Yojson.Safe.t -> Ast.block = function
  | `Variant (
    "CompoundStmt", Some (`Tuple [
      _source_info;
      `List statements
    ])
  ) ->
    statements |> List.map (parse_statement typemap)
  | yojson ->
    raise (Invalid_Yojson ("Invalid block data.", yojson))

let rec ast_of_yojson typemap function_typeinfo (definitions:Ast.definition list) : Yojson.Safe.t list -> Ast.definition list = function
  | `Variant (
    "FunctionDecl", Some (`Tuple [
      _metadata; (* filename, line num, col num, &c. *)
      `Assoc name_data;
      `Assoc [("type_ptr", `Int type_ptr)];
      `Assoc data
    ])
   ) as yojson :: _rest ->
      let name =
        begin match List.assoc_opt "name" name_data with
        | Some (`String name) -> name
        | _ -> raise (Invalid_Yojson ("Function name not found.", yojson))
        end
      in
      let {return_type; param_types= _} =
        begin match PointerMap.find_opt type_ptr function_typeinfo with
        | Some info -> info
        | None -> raise (Invalid_Yojson ("Function type not found.", yojson))
        end
      in
      let single_name = [return_type], name in
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
      FUNDEF (single_name, params, body) :: definitions
  | _ :: rest ->
    ast_of_yojson typemap function_typeinfo definitions rest
  | [] ->
    definitions

let ast_of_yojson (fname:string) : Yojson.Safe.t -> Ast.file = function
  | `Variant (
      "TranslationUnitDecl", Some (`Tuple [
        _metadata; (* ? *)
        `List decls;
        _any; (* This is empty. *)
        `Assoc data
      ]
      )) as yojson ->
        let typedata =
          begin match List.assoc_opt "types" data with
          | Some (`List typedata) -> typedata
          | _ -> raise (Invalid_Yojson ("Type data not found.", yojson))
          end
        in
        let typemap = make_typemap typedata in
        show_typemap typemap;
        let function_typeinfo = make_fuction_typeinfo typemap typedata in
        show_fuction_typeinfo function_typeinfo;
        let definitions = ast_of_yojson typemap function_typeinfo [] decls in
        fname, definitions
  | yojson ->
    raise (Invalid_Yojson ("Invalid AST Yojson.", yojson))

let parse_yojson fname =
  let yojson = Yojson.Safe.from_file fname in
  try (
    yojson 
    |> (ast_of_yojson fname) 
    |> Ast.show
    |> Printf.printf "%s"
  ) with
  | Invalid_Yojson (message, yojson) ->
    Printf.printf "%s\n" message;
    Format.printf "%a" Yojson.Safe.pp yojson
