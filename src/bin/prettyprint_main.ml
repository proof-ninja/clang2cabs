open Clang2cabs_lib
open Util

let run mas_file =
  let open Result.Let in
  let* ast = Ast.load_from_file mas_file in
  print_endline (Ast.show ast);
  Ok ()

let help () =
  let usage_msg =
    !%"Usage: %s <name>.mas\n\
       prettyprints abstract syntax trees in <name>.mas to the standard output.\n"
      Sys.argv.(0)
  in
  Printf.eprintf "%s%!" usage_msg

let dispatch_command () =
  assert (Array.length Sys.argv > 1);
  match Sys.argv.(1) with
  | "help" | "-h" | "-help" | "--help" -> help ();
  | filename ->
     begin match run filename with
     | Error exn -> raise exn
     | Ok () -> ()
     end

let main () =
  let len = Array.length Sys.argv in
  if len <= 1 then (
    help ();
    exit 1)
  else
    dispatch_command ()

let () = main ()
