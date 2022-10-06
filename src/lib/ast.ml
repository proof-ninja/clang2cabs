open Util

module Location = struct
  type t = {
    file : string option;
    start_line : int option;
    end_line : int option;
    start_column : int option;
    end_column : int option
  }

  let empty = {
    file= None;
    start_line= None;
    end_line= None;
    start_column= None;
    end_column= None
  }
end

module CType = struct
  type id = int

  type t =
    | Tvoid
    | Tbool
    | Tchar_s
    | Tchar
    | Tuchar
    | Tshort
    | Tushort
    | Tint
    | Tuint
    | Tlong
    | Tulong
    | Tlonglong
    | Tulonglong
    | Tfloat
    | Tdouble
    | Tarray of t * int
    | Tpointer of t
    | Tdefined of id
end

type field = {
  field_type: CType.t;
  field_name: string;
  bit_width_expr: expression option;
}

and record = {
  record_name: string;
  record_fields: field list;
}

and init_name_group = CType.t * init_name list

and name = string

and init_name = name * init_expression

and single_name = CType.t * name * Location.t

and variable_scope = {
  is_global : bool;
  is_static : bool;
  is_static_local : bool
}

and definition =
  | FUNDEF of single_name * single_name list * block * Location.t
  | DECDEF of init_name_group * variable_scope * Location.t
  | TYPEDEF of CType.id * string * Location.t
  | RECORDDEF of CType.id * record * Location.t

and block = statement list

and statement =
  | NOP
  | COMPUTATION of expression
  | BLOCK of block * Location.t
  | IF of expression * statement * statement * Location.t
  | FOR of expression * expression * expression * statement * Location.t
  | WHILE of expression * statement * Location.t
  | RETURN of expression option * Location.t
  | VARDECL of init_name_group * variable_scope * Location.t
  | RECORDDEC of CType.id * record * Location.t

and binary_operator =
  | ADD | SUB | MUL | DIV | MOD
  | AND | OR
  | EQ | NE | LT | GT | LE | GE
  | ASSIGN

and unary_operator =
  | MINUS | PLUS | NOT | BNOT | DEREF | ADDROF
  | PREINCR | PREDECR | POSINCR | POSDECR

and expression =
  | CONST_EXPR of expression * Location.t (** constant expression *)
  | UNARY of unary_operator * expression * Location.t
  | BINARY of binary_operator * expression * expression * Location.t
  | CONDITIONAL of expression * expression * expression * Location.t
  | CALL of string * expression list * Location.t
  | CONSTANT of constant * Location.t
  | PAREN of expression * Location.t
  | VARIABLE of string * Location.t
  | INDEX of expression * expression * Location.t
  | MEMBER of expression * string * Location.t
  | INIT_LIST of expression list * Location.t

and constant =
  | CONST_INT of string (* the textual representation *)

and init_expression =
  | NO_INIT
  | SINGLE_INIT of expression

let rec show_file indent = function (filename, definition_list) ->
  let defs =
    definition_list
    |> List.map (show_definition ("  " ^ indent))
    |> String.concat "\n"
  in
  indent ^ "File(name: " ^ filename ^ "\n" ^
  defs ^ "\n" ^
  ")"
and show_record_definition id { record_name; record_fields } _location =
  let show_field { field_type; field_name; bit_width_expr } =
    let field_type = show_ctype field_type in
    let bit_width_expr = bit_width_expr
      |> Option.map (fun expr -> " (bit_width: " ^ show_expression expr ^ ")")
      |> Option.value ~default:""
    in
    "  " ^ field_name ^ ": " ^ field_type ^ bit_width_expr
  in
  let fields =
    record_fields
    |> List.map show_field
    |> String.concat "\n"
  in
  "struct " ^ record_name ^ " {\n" ^
  fields ^ "\n" ^
  "}(User defined as " ^ string_of_int id ^ ")\n"
and show_variable_scope {is_global; is_static; is_static_local} =
  let info = [] in
  let info = if is_static_local then "static_local" :: info else info in
  let info = if is_static then "static" :: info else info in
  let info = if is_global then "global" :: info else info in
  String.concat " " info
and show_definition indent = function
  | FUNDEF ((return_type, func_name, _location1), single_name_list, block, _location2) ->
    let args =
      single_name_list
      |> List.map (fun (ctype, name, _location) -> name ^ ":" ^ show_ctype ctype)
      |> String.concat ", "
    in
    indent ^ "Function(\n" ^
    indent ^ "  name: " ^ func_name ^ "; return_type: " ^ show_ctype return_type ^ "\n" ^
    indent ^ "  arguments: " ^ args ^ "\n" ^
    (
      if List.is_empty block then
        ""
      else
        indent ^ "  {\n" ^
        show_block ("  " ^ indent) block ^ "\n" ^
        indent ^ "  }\n"
    ) ^
    indent ^ ")"
  | DECDEF (init_name_group, scope_info, _location) ->
    let init_name_group = show_init_name_group ("  " ^ indent) init_name_group in
    indent ^ "Decdef[" ^ show_variable_scope scope_info ^ "](\n" ^
    init_name_group ^ "\n" ^
    indent ^ ")"
  | TYPEDEF (id, name, _location) ->
    "type " ^ name ^ "(" ^ string_of_int id ^ ")\n"
  | RECORDDEF (id, record, location) ->
    show_record_definition id record location
and show_init_name_group indent (ctype, init_name_list) =
  let names =
    init_name_list
    |> List.map (fun init_name -> "  " ^ indent ^ show_init_name init_name)
    |> String.concat "\n"
  in
  indent ^ "names: \n" ^
  names ^ "\n" ^
  indent ^ "types: " ^ show_ctype ctype
and show_init_name (name, init_expr) =
  match init_expr with
  | NO_INIT ->
    name
  | SINGLE_INIT expr ->
    name ^ " = " ^ show_expression expr
and show_ctype = function
  | Tvoid -> "void"
  | Tbool -> "bool"
  | Tchar_s -> "char"
  | Tchar -> "signed char"
  | Tuchar -> "unsigned char"
  | Tshort -> "signed short"
  | Tushort -> "unsigned short"
  | Tint -> "signed int"
  | Tuint -> "unsigned int"
  | Tlong -> "signed long"
  | Tulong -> "unsigned long"
  | Tlonglong -> "signed long long"
  | Tulonglong -> "unsigned long long"
  | Tfloat -> "float"
  | Tdouble -> "double"
  | Tarray (tpe, len) -> "Type:" ^ show_ctype tpe ^ "[" ^ string_of_int len ^ "]"
  | Tpointer tpe -> "*" ^ "Type:" ^ show_ctype tpe
  | Tdefined p -> "(User Defined Type of ->" ^ string_of_int p ^ ")"
and show_block indent block =
  block
  |> List.map (show_statement indent)
  |> String.concat "\n"
and show_statement indent = function
  | NOP ->
    ""
  | COMPUTATION expr ->
    indent ^ show_expression expr
  | BLOCK (block, _location) ->
    indent ^ "{\n" ^
    show_block ("  " ^ indent) block ^ "\n" ^
    indent ^ "}"
  | IF (cond, if_true, if_false, _location) ->
    indent ^ "IF (" ^ show_expression cond ^ ") {\n" ^
    show_statement ("  " ^ indent) if_true ^ "\n" ^
    if if_false = NOP then
      indent ^ "}"
    else
      indent ^ "} else {\n" ^
      show_statement ("  " ^ indent) if_false ^ "\n" ^
      indent ^ "}"
  | FOR (init, cond, mut, stats, _location) ->
    indent ^ "FOR(\n" ^
    indent ^ "  " ^ show_expression init ^ "\n" ^
    indent ^ "  " ^ show_expression cond ^ "\n" ^
    indent ^ "  " ^ show_expression mut ^ "\n" ^
    indent ^ ") {\n" ^
    indent ^ show_statement ("  " ^ indent) stats ^ "\n" ^
    indent ^ "}"
  | WHILE (cond, stat, _location) ->
    indent ^ "WHILE (" ^ show_expression cond ^ ") {\n" ^
    show_statement ("  " ^ indent) stat ^ "\n" ^
    indent ^ "}"
  | RETURN (expr, _location) ->
    begin match expr with
    | Some expr -> indent ^ "RETURN " ^ show_expression expr
    | None -> indent ^ "RETURN"
    end
  | VARDECL (init_name_group, scope_info, _location) ->
    let init_name_group = show_init_name_group ("  " ^ indent) init_name_group in
    indent ^ "VARDECL[" ^ show_variable_scope scope_info ^ "](\n" ^
    init_name_group ^ "\n" ^
    indent ^ ")"
  | RECORDDEC (id, record, location) ->
    show_record_definition id record location
and show_expression = function
  | CONST_EXPR (expr, _location) ->
    show_expression expr
  | UNARY (op, expr, _location) ->
    show_unary_operator (show_expression expr) op
  | BINARY (op, lhs, rhs, _location) ->
    show_expression lhs ^ " " ^ show_binary_operator op ^ " " ^ show_expression rhs
  | CONDITIONAL (cond, lhs, rhs, _location) ->
    show_expression cond ^ " ? " ^ show_expression lhs ^ " : " ^ show_expression rhs
  | CALL (name, expr_list, _location) ->
    name ^ "(" ^ (expr_list |> List.map show_expression |> String.concat ", ") ^ ")"
  | CONSTANT (constant, _location) ->
    show_constant constant
  | PAREN (expr, _location) ->
    "(" ^ show_expression expr ^ ")"
  | VARIABLE (name, _location) ->
    name
  | INDEX (arr, idx, _location) ->
    show_expression arr ^ "[" ^ show_expression idx ^ "]"
  | MEMBER (expr, field, _location) ->
    show_expression expr ^ "." ^ field
  | INIT_LIST (exprs, _location) ->
    let exprs =
      exprs
      |> List.map show_expression
      |> String.concat ", "
    in
    "{ " ^ exprs ^ " }"
and show_unary_operator v = function
  | MINUS -> "-" ^ v
  | PLUS -> "+" ^ v
  | NOT -> "!" ^ v
  | BNOT -> "^" ^ v
  | DEREF -> "*" ^ v
  | ADDROF -> "&" ^ v
  | PREINCR -> "++" ^ v
  | PREDECR -> "--" ^ v
  | POSINCR -> v ^ "++"
  | POSDECR -> v ^ "--"
and show_binary_operator = function
  | ADD -> "+"
  | SUB -> "-"
  | MUL -> "*"
  | DIV -> "/"
  | MOD -> "%"
  | AND -> "&&"
  | OR -> "||"
  | EQ -> "=="
  | NE -> "!="
  | LT -> "<"
  | GT -> ">"
  | LE -> "<="
  | GE -> ">="
  | ASSIGN -> "="
and show_constant = function
  | CONST_INT i_as_str -> i_as_str

type file = string * definition list

let show file = show_file "" file

let save_to_file = Util.save_to_file

let load_from_file = Util.load_from_file
