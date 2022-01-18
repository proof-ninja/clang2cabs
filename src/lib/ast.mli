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


val show : file -> string

val show_type_specifier : type_specifier -> string

val save_to_file : string -> file -> (unit, exn) result

val load_from_file : string -> (file, exn) result
