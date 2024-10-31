open Js_of_ocaml
open Translate

let get_params () : (string * string) list = Url.Current.arguments
let query key params = List.assoc_opt key params

type operator =
  Init | Translate of lang * string

let operator_of_params params =
  match (query "lang" params , query "ja" params, query "al" params) with
  | (Some "al2ja", _, al) ->
     let text = Option.value al ~default:"" in
     Translate (Albhed_to_Ja, text)
  | (Some "ja2al", ja, _) ->
     let text = Option.value ja ~default:"" in
     Translate (Ja_to_Albhed, text)
  | _ -> Init

let init () =
  print_endline "init";
  (Dom_html.getElementById_exn "tweet")##.innerHTML := Js.string (Tweet_button.show Albhed_to_Ja "マギレヤキセ");
  ()
let translate lang src =
  print_endline "translate";
  let dst = Translate.f lang src in
  (Dom_html.getElementById_exn "tweet")##.innerHTML := Js.string (Tweet_button.show lang src);
  match lang with
  | Albhed_to_Ja ->
     (Dom_html.getElementById_exn "japanese")##.innerText := Js.string dst;
     (Dom_html.getElementById_exn "albhed")##.innerText := Js.string src
  | Ja_to_Albhed ->
     (Dom_html.getElementById_exn "japanese")##.innerText := Js.string src;
     (Dom_html.getElementById_exn "albhed")##.innerText := Js.string dst

let onload _ =
  let params = get_params () in
  begin match operator_of_params params with
  | Init -> init ()
  | Translate (lang, text) -> translate lang text
  end;
  Js._false


let () =
  Dom_html.window##.onload := Dom_html.handler onload
