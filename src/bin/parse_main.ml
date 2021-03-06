open Clang2cabs_lib
open Util

let get_clang_command_path () =
  let envvar = "CLANG_TO_YOJSON" in
  match Sys.getenv_opt envvar with
  | None -> failwith (!%"The environment variable '%s' is unbound." envvar)
  | Some command_path -> command_path

let parse_yojson filename =
  let open Result.Let in
  let* ast = Yojson2ast.parse_yojson (filename ^ ".yojson") in
  let* () = Ast.save_to_file (filename ^ ".mas") ast in
  Ok ()

let run dir =
  let cmd = get_clang_command_path () in
  Clang2yojson.convert_directory cmd dir
    |> Result.iter_m (fun f ->
      print_endline ("converted: "^f);
      let open Result.Let in
      let* ast = Yojson2ast.parse_yojson (f ^ ".yojson") in
      let* () = Ast.save_to_file (f ^ ".mas") ast in
      Ok ()
    )

let help () =
  let usage_msg =
    !%"Usage: %s {<dir> | --from-yojson <filename>}\n\
       parses each <name>.c and produces <name>.mas\n\
       in each subdirectory of the directory <dir>.\n\
       Or parses <filename>.yojson and produces <filename>.mas.\n"
      Sys.argv.(0)
  in
  Printf.eprintf "%s%!" usage_msg

let dispatch_command () =
  assert (Array.length Sys.argv > 1);
  match (
    match Sys.argv.(1) with
    | "help" | "-h" | "-help" | "--help" ->
      help ();
      Ok ()
    | "--from-yojson" ->
      assert (Array.length Sys.argv > 2);
      parse_yojson Sys.argv.(2)
    | dir ->
      run dir
  ) with
  | Error exn -> raise exn
  | Ok () -> ()

let main () =
  let len = Array.length Sys.argv in
  if len <= 1 then (
    help ();
    exit 1)
  else dispatch_command ()

let () = main ()
