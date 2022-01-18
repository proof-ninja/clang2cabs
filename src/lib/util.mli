val (!%) : ('a, unit, string) format -> 'a

val save_to_file : string -> 'a -> (unit, exn) result

val load_from_file : string -> ('a, exn) result

val ( let* ) : ('a, 'e) result -> ('a -> ('b, 'e) result) -> ('b, 'e) result

val result_sequence : ('a, 'e) result list -> ('a list, 'e) result

val result_map_m : ('a -> ('b, 'e) result) -> 'a list -> ('b list, 'e) result

val result_iter_m : ('a -> (unit, 'e) result) -> 'a list -> (unit, 'e) result
