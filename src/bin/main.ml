open Clang2cagbs_lib

let _ =
  let fname = Array.get Sys.argv 1 in
  Yojson2cabs.parse_yojson fname
