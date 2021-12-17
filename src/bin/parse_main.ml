open Printf

let run dir = printf "do parse c files in directory: '%s'\n" dir

let help () =
  let usage_msg =
    sprintf
      "Usage: %s <dir>\n\
       parses each <name>.c and produces <name>.mas\n\
       in each subdirectory of the directory <dir>.\n"
      Sys.argv.(0)
  in
  eprintf "%s%!" usage_msg

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
