type t

val fold : ('a -> Uchar.t -> 'a) -> 'a -> t -> 'a
val map : (Uchar.t -> Uchar.t) -> t -> t

val uchar_of_string : string -> Uchar.t
val string_of_uchar : Uchar.t -> string

val of_string : string -> t
val to_string : t -> string
