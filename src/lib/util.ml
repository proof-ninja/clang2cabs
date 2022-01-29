let (!%) = Printf.sprintf

let using_out filename f =
  let out = open_out filename in
  try
    let y = f out in
    close_out out; Ok y
  with e -> close_out out; Error e

let save_to_file filename x =
  using_out filename (fun out ->
      Marshal.to_channel out x [])

let using_in filename f =
  let in_ = open_in filename in
  try
    let y = f in_ in
    close_in in_; Ok y
  with e -> close_in in_; Error e

let load_from_file filename =
  using_in filename (fun ch ->
      Marshal.from_channel ch)

module Result = struct
  include Result
  
  let traverse f xs =
    let rec iter store = function
      | [] -> Ok (List.rev store)
      | x :: xs ->
        match f x with
        | Ok y -> iter (y :: store) xs
        | Error e -> Error e
    in
    iter [] xs

  let sequence ms =
    traverse Fun.id ms
  
  let iter_m f xs =
    let rec iter = function
      | [] -> Ok ()
      | x :: xs ->
         begin match f x with
         | Ok () -> iter xs
         | Error e -> Error e
         end
    in
    iter xs

  module Let = struct
    let ( let* ) m f = Result.bind m f
  end
end
