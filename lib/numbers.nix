# https://gist.github.com/corpix/f761c82c9d6fdbc1b3846b37e1020e11
{lib}:
with lib; rec {
  decToHex = let
    intToHex = [
      "0"
      "1"
      "2"
      "3"
      "4"
      "5"
      "6"
      "7"
      "8"
      "9"
      "a"
      "b"
      "c"
      "d"
      "e"
      "f"
    ];
    toHex' = q: a:
      if q > 0
      then
        (toHex'
          (q / 16)
          ((elemAt intToHex (mod q 16)) + a))
      else a;
  in
    v: toHex' v "";

  colorToHex = {
    r,
    g,
    b,
  }: "#${decToHex (r * 65536 + g * 256 + b)}";
}
