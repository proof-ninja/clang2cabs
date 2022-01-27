val (!%) : ('a, unit, string) format -> 'a

val save_to_file : string -> 'a -> (unit, exn) result

val load_from_file : string -> ('a, exn) result

module Result : sig
  include module type of Result
  
  val traverse : ('a -> ('b, 'e) result) -> 'a list -> ('b list, 'e) result

  val sequence : ('a, 'e) result list -> ('a list, 'e) result
  
  val iter_m : ('a -> (unit, 'e) result) -> 'a list -> (unit, 'e) result

  module Let : sig
    val ( let* ) : ('a, 'e) result -> ('a -> ('b, 'e) result) -> ('b, 'e) result
  end
end
