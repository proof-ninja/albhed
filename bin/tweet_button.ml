open Js_of_ocaml

let button_text = "アルベド語をツイートする"

let hashtag = Url.urlencode "アルベド語翻訳"

let body text =
  Printf.sprintf {|%s

翻訳をみる → |} text
  |> Url.urlencode

let show lang text =
  Printf.printf "Tweet_button.show: '%s'" text;
  let link =
    let query =
      match lang with
      | Translate.Albhed_to_Ja -> Url.encode_arguments [("lang", "al2ja"); ("al", text)]
      | Ja_to_Albhed -> Url.encode_arguments [("lang", "ja2al"); ("ja", text)]
    in
    let base = "proof-ninja.github.io/albhed" in
    "https://" ^ base ^ "?" ^ query
  in
  Printf.sprintf {|<a href="https://twitter.com/intent/tweet?hashtags=%s&ref_src=&text=%s&url=%s" class="twitter-share-button">%s</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>|}
    hashtag
    (body text) (Url.urlencode link) button_text
