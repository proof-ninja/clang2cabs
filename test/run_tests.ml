(*
   Run all the OCaml test suites defined in the project.
*)

let test_suites : unit Alcotest.test list =
  [
    ("lib.A", Test_lib.A.tests);
  ]

let () = Alcotest.run "clang2cabs" test_suites
