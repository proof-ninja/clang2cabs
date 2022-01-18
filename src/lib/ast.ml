type file = string * definition list

and type_specifier =
  | Tvoid
  | Tint

and specifier = type_specifier list

and decl_type =
  | JUSTBASE
  | ARRAY of decl_type

and init_name_group = specifier * init_name list

and name = string * decl_type

and init_name = name * init_expression

and single_name = specifier * string

and definition =
  | FUNDEF of single_name * single_name list * block
  | DECDEF of init_name_group (* global variable(s), or function prototype *)

and block = statement list

and statement =
  | NOP
  | COMPUTATION of expression
  | BLOCK of block
  | IF of expression * statement * statement
  | FOR of expression * expression * expression * statement
  | WHILE of expression * statement
  | RETURN of expression option
  | VARDECL of init_name_group

and binary_operator =
  | ADD | SUB | MUL | DIV | MOD
  | AND | OR
  | EQ | NE | LT | GT | LE | GE
  | ASSIGN

and unary_operator =
  | MINUS | PLUS | NOT | BNOT | MEMOF | ADDROF
  | PREINCR | PREDECR | POSINCR | POSDECR

and expression =
  | UNARY of unary_operator * expression
  | BINARY of binary_operator * expression * expression
  | CALL of string * expression list
  | CONSTANT of constant
  | PAREN of expression
  | VARIABLE of string
  | INDEX of expression * expression

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
and show_definition indent = function
  | FUNDEF ((return_type, func_name), single_name_list, block) ->
    let args =
      single_name_list
      |> List.map (fun (specifier, str) -> str ^ ":" ^ show_specifier specifier )
      |> String.concat ", "
    in
    indent ^ "Function(\n" ^
    indent ^ "  name: " ^ func_name ^ "; return_type: " ^ show_specifier return_type ^ "\n" ^
    indent ^ "  arguments: " ^ args ^ "\n" ^
    indent ^ "  {\n" ^
    show_block ("  " ^ indent) block ^ "\n" ^
    indent ^ "  }\n" ^
    indent ^ ")"
  | DECDEF init_name_group ->
    let init_name_group = show_init_name_group ("  " ^ indent) init_name_group in
    indent ^ "Decdef(\n" ^
    init_name_group ^ "\n" ^
    indent ^ ")"
and show_init_name_group indent (specifier, init_name_list) =
  let names =
    init_name_list
    |> List.map (fun init_name -> "  " ^ indent ^ show_init_name init_name)
    |> String.concat "\n"
  in
  indent ^ "names: \n" ^
  names ^ "\n" ^
  indent ^ "types: " ^ show_specifier specifier
and show_init_name ((name, decl_type), init_expr) =
  let name = show_decl_type decl_type ^ name in
  match init_expr with
  | NO_INIT ->
    name
  | SINGLE_INIT expr ->
    name ^ " = " ^ show_expression expr
and show_decl_type = function
  | JUSTBASE -> ""
  | ARRAY decl_type -> show_decl_type decl_type ^ "[]"
and show_specifier specifier_list =
  String.concat ", " @@ List.map show_type_specifier specifier_list
and show_type_specifier = function
  | Tvoid -> "void"
  | Tint -> "int"
and show_block indent block =
  block
  |> List.map (show_statement indent)
  |> String.concat "\n"
and show_statement indent = function
  | NOP ->
    ""
  | COMPUTATION expr ->
    indent ^ show_expression expr
  | BLOCK block ->
    indent ^ "{\n" ^
    show_block ("  " ^ indent) block ^ "\n" ^
    indent ^ "}"
  | IF (cond, if_true, if_false) ->
    indent ^ "IF (" ^ show_expression cond ^ ") {\n" ^
    show_statement ("  " ^ indent) if_true ^ "\n" ^
    if if_false = NOP then
      indent ^ "}"
    else
      indent ^ "} else {\n" ^
      show_statement ("  " ^ indent) if_false ^ "\n" ^
      indent ^ "}"
  | FOR (init, cond, mut, stats) ->
    indent ^ "FOR(\n" ^
    indent ^ "  " ^ show_expression init ^ "\n" ^
    indent ^ "  " ^ show_expression cond ^ "\n" ^
    indent ^ "  " ^ show_expression mut ^ "\n" ^
    indent ^ ") {\n" ^
    indent ^ show_statement ("  " ^ indent) stats ^ "\n" ^
    indent ^ "}"
  | WHILE (cond, stat) ->
    indent ^ "WHILE (" ^ show_expression cond ^ ") {\n" ^
    show_statement ("  " ^ indent) stat ^ "\n" ^
    indent ^ "}"
  | RETURN expr ->
    begin match expr with
    | Some expr -> indent ^ "RETURN " ^ show_expression expr
    | None -> indent ^ "RETURN"
    end
  | VARDECL init_name_group ->
    let init_name_group = show_init_name_group ("  " ^ indent) init_name_group in
    indent ^ "VARDECL(\n" ^
    init_name_group ^ "\n" ^
    indent ^ ")"
and show_expression = function
  | UNARY (op, expr) ->
    show_unary_operator (show_expression expr) op
  | BINARY (op, lhs, rhs) ->
    show_expression lhs ^ " " ^ show_binary_operator op ^ " " ^ show_expression rhs
  | CALL (name, expr_list) ->
    name ^ "(" ^ (expr_list |> List.map show_expression |> String.concat ", ") ^ ")"
  | CONSTANT constant ->
    show_constant constant
  | PAREN expr ->
    "(" ^ show_expression expr ^ ")"
  | VARIABLE name ->
    name
  | INDEX (arr, idx) ->
    show_expression arr ^ "[" ^ show_expression idx ^ "]"
and show_unary_operator v = function
  | MINUS -> "-" ^ v
  | PLUS -> "+" ^ v
  | NOT -> "!" ^ v
  | BNOT -> "^" ^ v
  | MEMOF -> "*" ^ v
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

let show file = show_file "" file

let save_to_file = Util.save_to_file

let load_from_file = Util.load_from_file
