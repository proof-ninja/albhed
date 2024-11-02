type t = string

let fold f init ustr =
  Uutf.String.fold_utf_8 (fun acc _i -> function
      | `Uchar uchar -> f acc uchar
      | `Malformed _s -> acc) init ustr

let map f ustr =
  let buf = Buffer.create (String.length ustr) in
  fold (fun buf uchar -> Uutf.Buffer.add_utf_8 buf (f uchar); buf) buf ustr
  |> Buffer.contents

let uchar_of_string s =
  let decoder = Uutf.decoder ~encoding:`UTF_8 (`String s) in
  match Uutf.decode decoder with
  | `Uchar u -> u
  | _ -> failwith "Invalid UTF-8 character"

let string_of_uchar uchar =
  let buf = Buffer.create 4 in
  Uutf.Buffer.add_utf_8 buf uchar;
  Buffer.contents buf

let of_string s = s
let to_string s = s
