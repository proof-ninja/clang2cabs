
(**
  Location infomations of the definition.
*)
module Location : sig
  type t = {
    file : string option;
    start_line : int option;
    end_line : int option;
    start_column : int option;
    end_column : int option
  }

  val empty : t
end

(**
  All types appearing in the source code.
*)
module CType : sig
  type id = int (** Unique ID assigned to every type *)

  type t =
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
    | Tarray of t * int (** [Array] type *)
    | Tpointer of t (** [Pointer] type *)
    | Tdefined of id (** User defined type like such as struct *)
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

and union = {
  union_name: string;
  union_fields: field list;
}

and enumerator = {
  enumerator_type: CType.t;
  enumerator_name: string;
  init_expr: expression option;
}

and enum = {
  enum_name: string;
  enumerators: enumerator list;
}

(**
  like name_group, except the declared variables are allowed to have initializers
  e.g.
    {[int x = 1, y = 2;]}
 *)
and init_name_group = CType.t * init_name list

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
and single_name = CType.t * name * Location.t

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
  | FUNDEF of single_name * single_name list * block * Location.t
  (**
     When you got [FUNDEF(sname, args, body)],
     [sname] is the function's name and type.
     [args] is the arguments' names and types.
     [body] is the function's body and function prototype has empty body.
   *)
  | DECDEF of init_name_group * variable_scope * Location.t (** global variable(s) *)
  | TYPEDEF of CType.id * string * Location.t (** A definition of type *)
  | RECORDDEF of CType.id * record * Location.t (** A definition of struct *)
  | UNIONDEF of CType.id * union * Location.t (** A definition of union *)
  | ENUMDEF of CType.id * enum * Location.t (** A definition of enum *)

and block = statement list

and statement =
  | NOP (** empty statement *)
  | COMPUTATION of expression (** simple expression *)
  | BLOCK of block * Location.t (** block of statements [{ st; ... st; }] *)
  | IF of expression * statement * statement * Location.t
  (** if statement
        {[if (cond) {
          st1;
        } else {
          st2;
        }
        ]}
   *)
  | FOR of expression * expression * expression * statement * Location.t
  (** for loop statement
      {[
      for (e1; e2; e3) {
        st;
      }
      ]}
   *)
  | WHILE of expression * statement * Location.t
  (** while loop statemnt
      {[
      while (cond) {
        st;
      }
      ]}
   *)
  | RETURN of expression option * Location.t
  (** return statement
      {[return e;]}
   *)
  | VARDECL of init_name_group * variable_scope * Location.t
  (** variable declaration *)
  | RECORDDEC of CType.id * record * Location.t
  (** struct definition in statements *)
  | UNIONDEC of CType.id * union * Location.t
  (** union definition in statements *)
  | ENUMDEC of CType.id * enum * Location.t
  (** enum definition in statements *)

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
  | DEREF (** [*e] *)
  | ADDROF (** [&e] *)
  | PREINCR (** [++e] *)
  | PREDECR (** [--e] *)
  | POSINCR (** [e++] *)
  | POSDECR (** [e--] *)

and expression =
  | CONST_EXPR of expression * Location.t (** constant expression *)
  | UNARY of unary_operator * expression * Location.t  (** unary operation *)
  | BINARY of binary_operator * expression * expression * Location.t (** binary operation *)
  | CONDITIONAL of expression * expression * expression * Location.t (** conditional operator *)
  | CALL of string * expression list * Location.t (** function call [f(e1, ..., en)] *)
  | CONSTANT of constant * Location.t (** constant expression *)
  | PAREN of expression * Location.t (** [(expression)] *)
  | VARIABLE of string * Location.t (** variable *)
  | INDEX of expression * expression * Location.t (** array index expression [a[i]] *)
  | MEMBER of expression * string * Location.t (** record's field expression [a.x] *)
  | INIT_LIST of expression list * Location.t (** initializer list [struct foo = { 1, { 2, 3 } }] *)

and constant =
  | CONST_INT of string (** the textual representation *)
  | CONST_FLOAT of string (** ditto *)

and init_expression =
  | NO_INIT
  | SINGLE_INIT of expression

type file = string * definition list

val show : file -> string

val show_ctype : CType.t -> string

val save_to_file : string -> file -> (unit, exn) result

val load_from_file : string -> (file, exn) result
