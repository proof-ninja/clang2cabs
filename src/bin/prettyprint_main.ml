open Clang2cabs_lib
open Util

let run filename =
  Printf.printf "%s" @@
  match Yojson2ast.parse_yojson filename with
  | Ok ast -> !%"%s" (Ast.show ast)
  | Error (message, yojson) -> !%"%s\n%s\n" message yojson

let help () =
  let usage_msg =
    !%"Usage: %s <filename>\n\
       Parse yojson file and pretty print it\n"
      Sys.argv.(0)
  in
  Printf.eprintf "%s%!" usage_msg

let dispatch_command () =
  assert (Array.length Sys.argv > 1);
  match Sys.argv.(1) with
  | "help" | "-h" | "-help" | "--help" -> help ()
  | filename ->
      run filename

let main () =
  let len = Array.length Sys.argv in
  if len <= 1 then (
    help ();
    exit 1)
  else dispatch_command ()

let () = main ()
