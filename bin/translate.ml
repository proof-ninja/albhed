open Util

type lang = Albhed_to_Ja | Ja_to_Albhed

let table = [ (*c.f. https://www.jp.square-enix.com/column/detail/3/ *)
    ("あ", "ワ"); ("い", "ミ"); ("う", "フ"); ("え", "ネ"); ("お", "ト");
    ("か", "ア"); ("き", "チ"); ("く", "ル"); ("け", "テ"); ("こ", "ヨ");
    ("さ", "ラ"); ("し", "キ"); ("す", "ヌ"); ("せ", "ヘ"); ("そ", "ホ");
    ("た", "サ"); ("ち", "ヒ"); ("つ", "ユ"); ("て", "セ"); ("と", "ソ");
    ("な", "ハ"); ("に", "シ"); ("ぬ", "ス"); ("ね", "メ"); ("の", "オ");
    ("は", "マ"); ("ひ", "リ"); ("ふ", "ク"); ("へ", "ケ"); ("ほ", "ロ");
    ("ま", "ヤ"); ("み", "イ"); ("む", "ツ"); ("め", "レ"); ("も", "コ");
    ("や", "タ"); ("ゆ", "ヲ"); ("よ", "モ");
    ("ら", "ナ"); ("り", "ニ"); ("る", "ウ"); ("れ", "エ"); ("ろ", "ノ");
    ("わ", "カ"); ("を", "ム");
    ("ん", "ン"); ("っ", "ッ");
    ("が", "ダ"); ("ぎ", "ヂ"); ("ぐ", "ヅ"); ("げ", "デ"); ("ご", "ゾ");
    ("ざ", "バ"); ("じ", "ギ"); ("ず", "ブ"); ("ぜ", "ゲ"); ("ぞ", "ボ");
    ("だ", "ガ"); ("ぢ", "ビ"); ("づ", "グ"); ("で", "ベ"); ("ど", "ゴ");
    ("ば", "ザ"); ("び", "ジ"); ("ぶ", "ズ"); ("べ", "ゼ"); ("ぼ", "ド");
    ("ぱ", "プ"); ("ぴ", "ポ"); ("ぷ", "ピ"); ("ぺ", "パ"); ("ぽ", "ペ");
  ]

let albhed_to_ja uchar =
  match List.find_opt (fun (_ja, al) -> Utf8.uchar_of_string al = uchar) table with
  | None -> uchar
  | Some (ja, _) -> Utf8.uchar_of_string ja

let ja_to_albhed uchar =
  match List.find_opt (fun (ja, _al) -> Utf8.uchar_of_string ja = uchar) table with
  | None -> uchar
  | Some (_, al) -> Utf8.uchar_of_string al

let f lang text =
  match lang with
  | Albhed_to_Ja ->
     Utf8.of_string text
     |> Utf8.map albhed_to_ja
     |> Utf8.to_string
  | Ja_to_Albhed ->
     Utf8.of_string text
     |> Utf8.map ja_to_albhed
     |> Utf8.to_string
