open Clang2cabs_lib.Util

let is_c_file name = Filename.check_suffix name ".c"

let find_c_files dir =
  if Sys.is_directory dir = false then failwith (!%"no such directory: '%s'" dir);
  let rec find path store name =
    let filepath = Filename.concat path name in
    if Sys.is_directory filepath then
      let names = Sys.readdir filepath in
      Array.fold_right (fun name store -> find filepath store name) names store
    else
      if is_c_file name then
        filepath :: store
      else
        store
  in
  find "" [] dir

let clang2yojson command cfile =
  let cmd = command ^ " " ^ cfile in
  let result = Sys.command cmd in
  if result <> 0 then failwith "clang2yojson";
  cfile

let convert_directory command dir =
  find_c_files dir
  |> List.map (clang2yojson command)
