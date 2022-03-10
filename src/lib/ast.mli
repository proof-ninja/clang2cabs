type file = string * definition list

and type_specifier =
  | Tvoid (** [void] type *)
  | Tint (** [int] type *)

(**
   In the 'small C' range, only type information is passed here.
 *)
and specifier = type_specifier list

(**
  Declarator type. They modify the base type given in the specifier.
  e.g.
  - [int[3][4]] -> [ARRAY(ARRAY(JUSTBASE, "3"), "4")]
  - [int]     -> [JUSTBASE]
*)
and decl_type =
  | JUSTBASE
  | PTR of decl_type (** This is not used currently. *)
  | ARRAY of decl_type * expression

(**
  like name_group, except the declared variables are allowed to have initializers
  e.g.
    {[int x = 1, y = 2;]}
 *)
and init_name_group = specifier * init_name list

(**
  The decl_type is in the order in which they are printed. Only the name of
  the declared identifier is pulled out. The attributes are those that are
  printed after the declarator
  e.g.
    in [int x[]], [x[]] is the declarator; [x] will be pulled out as
    the string, and decl_type will be [ARRAY(JUSTBASE)]
 *)
and name = string * decl_type

(**
   A variable declarator [name] with an initializer [init_expression].
 *)
and init_name = name * init_expression

(**
   Single names are for declarations that cannot come in groups, like
   function parameters and functions.
 *)
and single_name = specifier * name

(**
   Declaration definition (at toplevel)
 *)
and definition =
  | FUNDEF of single_name * single_name list * block
  (**
     When you got [FUNDEF(sname, args, body)],
     [sname] is the function's name and type.
     [args] is the arguments' names and types.
     [body] is the function's body and function prototype has empty body.
   *)
  | DECDEF of init_name_group (** global variable(s) *)

and block = statement list

and statement =
  | NOP (** empty statement *)
  | COMPUTATION of expression (** simple expression *)
  | BLOCK of block (** block of statements [{ st; ... st; }] *)
  | IF of expression * statement * statement
  (** if statement
        {[if (cond) {
          st1;
        } else {
          st2;
        }
        ]}
   *)
  | FOR of expression * expression * expression * statement
  (** for loop statement
      {[
      for (e1; e2; e3) {
        st;
      }
      ]}
   *)
  | WHILE of expression * statement
  (** while loop statemnt
      {[
      while (cond) {
        st;
      }
      ]}
   *)
  | RETURN of expression option
  (** return statement
      {[return e;]}
   *)
  | VARDECL of init_name_group
  (** variable declaration *)

and binary_operator =
  | ADD (** [e1 + e2] *)
  | SUB (** [e1 - e2] *)
  | MUL (** [e1 * e2] *)
  | DIV (** [e1 / e2] *)
  | MOD (** [e1 % e2] *)
  | AND (** [e1 && e2] *)
  | OR  (** [e1 || e2] *)
  | EQ  (** [e1 == e2] *)
  | NE  (** [e1 != e2] *)
  | LT  (** [e1 < e2] *)
  | GT  (** [e1 > e2] *)
  | LE  (** [e1 <= e2] *)
  | GE  (** [e1 >= e2] *)
  | ASSIGN (** [e1 = e2] *)

and unary_operator =
  | MINUS  (** [-e] *)
  | PLUS  (** [+e] *)
  | NOT (** [!e] *)
  | BNOT (** unused [~e] *)
  | MEMOF (** unused [*e] *)
  | ADDROF (** unused [&e] *)
  | PREINCR (** [++e] *)
  | PREDECR (** [--e] *)
  | POSINCR (** [e++] *)
  | POSDECR (** [e--] *)

and expression =
  | UNARY of unary_operator * expression  (** unary operation *)
  | BINARY of binary_operator * expression * expression (** binary operation *)
  | CALL of string * expression list (** function call [f(e1, ..., en)] *)
  | CONSTANT of constant (** constant expression *)
  | PAREN of expression (** [(expression)] *)
  | VARIABLE of string (** variable *)
  | INDEX of expression * expression (** array index expression [a[i]] *)

and constant =
  | CONST_INT of string (** the textual representation *)

and init_expression =
  | NO_INIT
  | SINGLE_INIT of expression


val show : file -> string

val show_type_specifier : type_specifier -> string

val save_to_file : string -> file -> (unit, exn) result

val load_from_file : string -> (file, exn) result
