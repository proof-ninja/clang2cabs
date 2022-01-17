exception Invalid_Yojson of string * Yojson.Safe.t

val parse_yojson : string -> (Ast.file, (string * string)) result
