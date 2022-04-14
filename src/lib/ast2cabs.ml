exception Cannot_convert of string
exception Unimplemented_error of string

let dummy_loc: Cabs.cabsloc = {
  lineno= 0;
  filename= "";
  byteno= 0;
  ident= 0;
}

let conv_location : Ast.location -> Cabs.cabsloc = function
  | Ast.{ file; start_line; _ } ->
    Cabs.{
      lineno= Option.value ~default:0 start_line;
      filename= Option.value ~default:"" file;
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
  | Ast.UNARY (unary_operator, expression, _location) ->
    Cabs.UNARY (
      conv_unary_operator unary_operator,
      conv_expression expression
    )
  | Ast.BINARY (binary_operator, expr1, expr2, _location) ->
    Cabs.BINARY (
      conv_binary_operator binary_operator,
      conv_expression expr1,
      conv_expression expr2
    )
  | Ast.CALL (name, exprs, _location) ->
    Cabs.CALL (
      Cabs.CONSTANT (Cabs.CONST_STRING name),
      List.map conv_expression exprs
    ) 
  | Ast.CONSTANT (constant, _location) ->
    Cabs.CONSTANT (conv_constant constant)
  | Ast.PAREN (expression, _location) ->
    conv_expression expression
  | Ast.VARIABLE (name, _location) ->
    Cabs.VARIABLE name
  | Ast.INDEX (arr, idx, _location) ->
    Cabs.INDEX (
      conv_expression arr,
      conv_expression idx
    )

let rec conv_statement : Ast.statement -> Cabs.statement = function
  | Ast.NOP -> Cabs.NOP dummy_loc
  | Ast.COMPUTATION expression ->
    Cabs.COMPUTATION (conv_expression expression, dummy_loc)
  | Ast.BLOCK (block, location) ->
    Cabs.BLOCK (conv_block block, conv_location location)
  | Ast.IF (cond, if_stmt, else_stmt, location) ->
    Cabs.IF (
      conv_expression cond,
      conv_statement if_stmt,
      conv_statement else_stmt,
      conv_location location
    )
  | Ast.FOR (_init, _cond, _after, _stmt, _location) ->
    raise (Cannot_convert "Cabs does not support FOR statement")
  | Ast.WHILE (cond, stmt, location) ->
    Cabs.WHILE (
      conv_expression cond,
      conv_statement stmt,
      conv_location location
    )
  | Ast.RETURN ((Some expression), location) ->
    Cabs.RETURN (conv_expression expression, conv_location location)
  | Ast.RETURN (None, _location) ->
    raise (Cannot_convert "Cabs does not support empty RETURN statement")
  | Ast.VARDECL (init_name_group, _, location) ->
    Cabs.DEFINITION (Cabs.DECDEF (
      conv_init_name_group init_name_group,
      conv_location location
    ))

and conv_block block : Cabs.block = {
  blabels= [];
  battrs= [];
  bstmts= List.map conv_statement block
}

and conv_ctype : Ast.ctype -> Cabs.specifier = function
  | Ast.Tvoid -> [Cabs.SpecType Cabs.Tvoid]
  | Ast.Tint -> [Cabs.SpecType Cabs.Tint]
  | _ -> raise (Unimplemented_error "Cabs cannot accept this type.")

and conv_name name : Cabs.name =
  (* CAUTION: We don't treat decl_types. *)
  name, Cabs.JUSTBASE, [], dummy_loc

and conv_single_name (ctype, name, _location) : Cabs.single_name =
  (conv_ctype ctype), (conv_name name)

and conv_init_expression : Ast.init_expression -> Cabs.init_expression = function
  | Ast.NO_INIT -> Cabs.NO_INIT
  | Ast.SINGLE_INIT expr -> Cabs.SINGLE_INIT (conv_expression expr)

and conv_init_name (name, init_expression) =
  (conv_name name), (conv_init_expression init_expression)

and conv_init_name_group (ctype, init_names) =
  (conv_ctype ctype), List.map conv_init_name init_names

let conv_definition : Ast.definition -> Cabs.definition = function
  | Ast.FUNDEF (single_name, _single_names, block, location) ->
    let location = conv_location location in
    (* Cabs.FUNDEF does not contain parameter list. *)
    Cabs.FUNDEF (
      conv_single_name single_name,
      (* List.map conv_single_name single_names, *)
      conv_block block,
      location,
      location
    )
  | Ast.DECDEF (init_name_group, _scope, location) ->
    Cabs.DECDEF (
      conv_init_name_group init_name_group,
      conv_location location
    )

let conv_file (filename, definitions) : Cabs.file = filename, List.map conv_definition definitions

let cabs_of_ast file = conv_file file
