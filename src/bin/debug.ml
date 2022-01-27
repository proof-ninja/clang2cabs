open Clang2cabs_lib
open Util

let get_clang_command_path () =
  let envvar = "CLANG_TO_YOJSON" in
  match Sys.getenv_opt envvar with
  | None -> failwith (!%"The environment variable '%s' is unbound." envvar)
  | Some command_path -> command_path

let run filename =
  let open Result.Let in
  let* ast = Yojson2ast.parse_yojson filename in
  print_endline (Ast.show ast);
  Ok ()

let help () =
  let usage_msg =
    !%"Usage: %s <filename>.yojson\n\
       parses each <filename>.yojson and pretty print it.\n"
      Sys.argv.(0)
  in
  Printf.eprintf "%s%!" usage_msg

let dispatch_command () =
  assert (Array.length Sys.argv > 1);
  match Sys.argv.(1) with
  | "help" | "-h" | "-help" | "--help" -> help ()
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
  else dispatch_command ()

let () = main ()
