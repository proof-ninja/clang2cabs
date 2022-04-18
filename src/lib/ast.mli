
(**
  Location infomations of the definition.
*)
type location = {
  file : string option;
  start_line : int option;
  end_line : int option;
  start_column : int option;
  end_column : int option
}

val empty_location : location

type file = string * definition list

and ctype =
  | Tvoid (** [void] type *)
  | Tbool (** [bool] type *)
  | Tchar_s (** [char] type *)
  | Tchar (** [signed char] type *)
  | Tuchar (** [unsigned char] type *)
  | Tshort (** [signed short] type *)
  | Tushort (** [unsigned short] type *)
  | Tint (** [signed int] type *)
  | Tuint (** [unsigned int] type *)
  | Tlong (** [signed long] type *)
  | Tulong (** [unsigned long] type *)
  | Tlonglong (** [signed long long] type *)
  | Tulonglong (** [unsigned long long] type *)
  | Tfloat (** [float] type *)
  | Tdouble (** [double] type *)
  | Tarray of ctype * int (** [Array] type *)
  | Tpointer of ctype (** [Pointer] type *)
  | Trecord of { name: string; fields: record_field list; location: location }

and record_field = {
  ctype: ctype;
  name: string;
}

(**
  like name_group, except the declared variables are allowed to have initializers
  e.g.
    {[int x = 1, y = 2;]}
 *)

and init_name_group = ctype * init_name list

(**
  A name of symbol.
 *)
and name = string

(**
   A variable declarator [name] with an initializer [init_expression].
 *)
and init_name = name * init_expression

(**
   Single names are for declarations that cannot come in groups, like
   function parameters and functions.
 *)
and single_name = ctype * name * location

(**
  The variable's scope info.
*)
and variable_scope = {
  is_global : bool;
  is_static : bool;
  is_static_local : bool
}

(**
   Declaration definition (at toplevel)
 *)
and definition =
  | FUNDEF of single_name * single_name list * block * location
  (**
     When you got [FUNDEF(sname, args, body)],
     [sname] is the function's name and type.
     [args] is the arguments' names and types.
     [body] is the function's body and function prototype has empty body.
   *)
  | DECDEF of init_name_group * variable_scope * location (** global variable(s) *)

and block = statement list

and statement =
  | NOP (** empty statement *)
  | COMPUTATION of expression (** simple expression *)
  | BLOCK of block * location (** block of statements [{ st; ... st; }] *)
  | IF of expression * statement * statement * location
  (** if statement
        {[if (cond) {
          st1;
        } else {
          st2;
        }
        ]}
   *)
  | FOR of expression * expression * expression * statement * location
  (** for loop statement
      {[
      for (e1; e2; e3) {
        st;
      }
      ]}
   *)
  | WHILE of expression * statement * location
  (** while loop statemnt
      {[
      while (cond) {
        st;
      }
      ]}
   *)
  | RETURN of expression option * location
  (** return statement
      {[return e;]}
   *)
  | VARDECL of init_name_group * variable_scope * location
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
  | UNARY of unary_operator * expression * location  (** unary operation *)
  | BINARY of binary_operator * expression * expression * location (** binary operation *)
  | CALL of string * expression list * location (** function call [f(e1, ..., en)] *)
  | CONSTANT of constant * location (** constant expression *)
  | PAREN of expression * location (** [(expression)] *)
  | VARIABLE of string * location (** variable *)
  | INDEX of expression * expression * location (** array index expression [a[i]] *)
  | MEMBER of expression * string * location (** record's field expression [a.x] *)
  | INIT_LIST of expression list * location (** initializer list [struct foo = { 1, { 2, 3 } }] *)

and constant =
  | CONST_INT of string (** the textual representation *)

and init_expression =
  | NO_INIT
  | SINGLE_INIT of expression


val show : file -> string

val show_ctype : ctype -> string

val save_to_file : string -> file -> (unit, exn) result

val load_from_file : string -> (file, exn) result
