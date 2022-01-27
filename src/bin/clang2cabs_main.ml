open Clang2cabs_lib
open Util

let save_cabs_to_file filename (cabs : Cabs.file) =
  Util.save_to_file filename cabs

let run mas_file =
  let open Result.Let in
  let* ast = Ast.load_from_file mas_file in
  let cabs = Ast2cabs.cabs_of_ast ast in
  let filename = (Filename.chop_suffix mas_file ".mas") ^ ".cabs" in
  save_cabs_to_file filename cabs

let help () =
  let usage_msg =
    !%"Usage: %s <name>.mas\n\
       translates the clang abstract syntax trees in <name>.mas\n\
       into a CABS file <name>.cabs\n"
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
