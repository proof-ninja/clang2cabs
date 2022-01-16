open Clang2cabs_lib
open Util

let get_clang_command_path () =
  let envvar = "CLANG_TO_YOJSON" in
  match Sys.getenv_opt envvar with
  | None -> failwith (!%"The environment variable '%s' is unbound." envvar)
  | Some command_path -> command_path

let run dir =
  let cmd = get_clang_command_path () in
  Clang2yojson.convert_directory cmd dir
    |> List.iter (fun f ->
      print_endline ("converted: "^f);
      (* TODO: We should output serialized AST files instead of prettyprinting. *)
      match Yojson2ast.parse_yojson (f ^ ".yojson") with
      | Ok ast -> Printf.printf "%s" (Ast.show ast)
      | Error (message, yojson) -> Printf.printf "%s\n%s\n" message yojson
    );
  Printf.printf "do parse c files in directory: '%s'\n" dir

let help () =
  let usage_msg =
    !%"Usage: %s <dir>\n\
       parses each <name>.c and produces <name>.mas\n\
       in each subdirectory of the directory <dir>.\n"
      Sys.argv.(0)
  in
  Printf.eprintf "%s%!" usage_msg

let dispatch_command () =
  assert (Array.length Sys.argv > 1);
  match Sys.argv.(1) with
  | "help" | "-h" | "-help" | "--help" -> help ()
  | dir ->
      run dir

let main () =
  let len = Array.length Sys.argv in
  if len <= 1 then (
    help ();
    exit 1)
  else dispatch_command ()

let () = main ()
