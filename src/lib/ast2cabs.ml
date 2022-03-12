exception Cannot_convert of string
exception Unimplemented_error of string

let dummy_loc: Cabs.cabsloc = {
  lineno= 0;
  filename= "";
  byteno= 0;
  ident= 0;
}

let conv_constant : Ast.constant -> Cabs.constant = function
  | Ast.CONST_INT i -> Cabs.CONST_INT i

let conv_binary_operator : Ast.binary_operator -> Cabs.binary_operator = function
  | Ast.ADD -> Cabs.ADD
  | Ast.SUB -> Cabs.SUB
  | Ast.MUL -> Cabs.MUL
  | Ast.DIV -> Cabs.DIV
  | Ast.MOD -> Cabs.MOD
  | Ast.AND -> Cabs.AND
  | Ast.OR -> Cabs.OR
  | Ast.EQ -> Cabs.EQ
  | Ast.NE -> Cabs.NE
  | Ast.LT -> Cabs.LT
  | Ast.GT -> Cabs.GT
  | Ast.LE -> Cabs.LE
  | Ast.GE -> Cabs.GE
  | Ast.ASSIGN -> Cabs.ASSIGN

let conv_unary_operator : Ast.unary_operator -> Cabs.unary_operator = function
  | Ast.MINUS -> Cabs.MINUS
  | Ast.PLUS -> Cabs.PLUS
  | Ast.NOT -> Cabs.NOT
  | Ast.BNOT -> Cabs.BNOT
  | Ast.MEMOF -> Cabs.MEMOF
  | Ast.ADDROF -> Cabs.ADDROF
  | Ast.PREINCR -> Cabs.PREINCR
  | Ast.PREDECR -> Cabs.PREDECR
  | Ast.POSINCR -> Cabs.POSINCR
  | Ast.POSDECR -> Cabs.POSDECR

let rec conv_expression : Ast.expression -> Cabs.expression = function
  | Ast.UNARY (unary_operator, expression) ->
    Cabs.UNARY (
      conv_unary_operator unary_operator,
      conv_expression expression
    )
  | Ast.BINARY (binary_operator, expr1, expr2) ->
    Cabs.BINARY (
      conv_binary_operator binary_operator,
      conv_expression expr1,
      conv_expression expr2
    )
  | Ast.CALL (name, exprs) ->
    Cabs.CALL (
      Cabs.CONSTANT (Cabs.CONST_STRING name),
      List.map conv_expression exprs
    ) 
  | Ast.CONSTANT constant ->
    Cabs.CONSTANT (conv_constant constant)
  | Ast.PAREN expression ->
    conv_expression expression
  | Ast.VARIABLE name ->
    Cabs.VARIABLE name
  | Ast.INDEX (arr, idx) ->
    Cabs.INDEX (
      conv_expression arr,
      conv_expression idx
    )

let rec conv_statement : Ast.statement -> Cabs.statement = function
  | Ast.NOP -> Cabs.NOP dummy_loc
  | Ast.COMPUTATION expression ->
    Cabs.COMPUTATION (conv_expression expression, dummy_loc)
  | Ast.BLOCK block ->
    Cabs.BLOCK (conv_block block, dummy_loc)
  | Ast.IF (cond, if_stmt, else_stmt) ->
    Cabs.IF (
      conv_expression cond,
      conv_statement if_stmt,
      conv_statement else_stmt,
      dummy_loc
    )
  | Ast.FOR (_init, _cond, _after, _stmt) ->
    raise (Cannot_convert "Cabs does not support FOR statement")
  | Ast.WHILE (cond, stmt) ->
    Cabs.WHILE (
      conv_expression cond,
      conv_statement stmt,
      dummy_loc
    )
  | Ast.RETURN (Some expression) ->
    Cabs.RETURN (conv_expression expression, dummy_loc)
  | Ast.RETURN None ->
    raise (Cannot_convert "Cabs does not support empty RETURN statement")
  | Ast.VARDECL init_name_group ->
    Cabs.DEFINITION (Cabs.DECDEF (conv_init_name_group init_name_group, dummy_loc))

and conv_block block : Cabs.block = {
  blabels= [];
  battrs= [];
  bstmts= List.map conv_statement block
}

(* and conv_field_group (specifier, name_expr_list) =
  let specifier = conv_specifiler specifier in
  let name_expr_list = 
    name_expr_list
    |> List.map (fun (name, expr_opt) ->
      (
        conv_name name,
        Option.map conv_expression expr_opt
      )
    )
  in
  specifier, name_expr_list *)

and conv_type_specifier : Ast.type_specifier -> Cabs.typeSpecifier = function
  | Ast.Tvoid -> Cabs.Tvoid
  | Ast.Tint -> Cabs.Tint
  | _ -> raise (Unimplemented_error "Cabs cannot accept this type.")

and conv_specifiler type_specifiers : Cabs.specifier =
  List.map (fun ts -> Cabs.SpecType (conv_type_specifier ts)) type_specifiers

and conv_decl_type : Ast.decl_type -> Cabs.decl_type = function
  | Ast.JUSTBASE -> Cabs.JUSTBASE
  | Ast.PTR decl_type ->
    Cabs.PTR ([], conv_decl_type decl_type)
  | Ast.ARRAY (decl_type, expr) ->
    Cabs.ARRAY (conv_decl_type decl_type, [], conv_expression expr)

and conv_name (name, decl_type) : Cabs.name =
  name, conv_decl_type decl_type, [], dummy_loc

and conv_single_name (specifiler, name) : Cabs.single_name =
  (conv_specifiler specifiler), (conv_name name)

and conv_init_expression : Ast.init_expression -> Cabs.init_expression = function
  | Ast.NO_INIT -> Cabs.NO_INIT
  | Ast.SINGLE_INIT expr -> Cabs.SINGLE_INIT (conv_expression expr)

and conv_init_name (name, init_expression) =
  (conv_name name), (conv_init_expression init_expression)

and conv_init_name_group (specifier, init_names) =
  (conv_specifiler specifier), List.map conv_init_name init_names

let conv_definition : Ast.definition -> Cabs.definition = function
  | Ast.FUNDEF (single_name, _single_names, block) ->
    (* Cabs.FUNDEF does not contain parameter list. *)
    Cabs.FUNDEF (
      conv_single_name single_name,
      (* List.map conv_single_name single_names, *)
      conv_block block,
      dummy_loc,
      dummy_loc
    )
  | Ast.DECDEF init_name_group ->
    Cabs.DECDEF (conv_init_name_group init_name_group, dummy_loc)

let conv_file (filename, definitions) : Cabs.file = filename, List.map conv_definition definitions

let cabs_of_ast file = conv_file file
