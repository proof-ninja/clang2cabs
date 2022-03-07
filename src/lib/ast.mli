type file = string * definition list

and type_specifier =
  | Tvoid
  | Tint

(* In the 'small C' range, only type information is passed here. *)
and specifier = type_specifier list

(* Declarator type. They modify the base type given in the specifier.
 * e.g.
 *   int[3][4] -> ARRAY(ARRAY(JUSTBASE, "3"), "4")
 *   int     -> JUSTBASE
 *)
and decl_type =
  | JUSTBASE
  | PTR of decl_type (* This is not used currently. *)
  | ARRAY of decl_type * expression

(* like name_group, except the declared variables are allowed to have initializers
 * e.g.
 *   int x = 1, y = 2; 
 *)
and init_name_group = specifier * init_name list

(* The decl_type is in the order in which they are printed. Only the name of
 * the declared identifier is pulled out. The attributes are those that are
 * printed after the declarator
 * e.g.
 *   in "int x[]", "x[]" is the declarator; "x" will be pulled out as
 *   the string, and decl_type will be ARRAY(JUSTBASE)
 *)
and name = string * decl_type

(* A variable declarator ("name") with an initializer. *)
and init_name = name * init_expression

(* Single names are for declarations that cannot come in groups, like
 * function parameters and functions.
 *)
and single_name = specifier * name

(*
 * Declaration definition (at toplevel)
 *)
and definition =
  (*
   * single_name: The function's name and type
   * single_name_list: The arguments' names and types
   * block: The function's body
   *)
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
