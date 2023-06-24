{lib}:
with import ./numbers.nix {inherit lib;}; let
  ctp = import ./catppuccin.nix;
in rec {
  americano =
    ctp.mocha
    // {
      base = {
        r = 0;
        g = 0;
        b = 0;
      };
      mantle = {
        r = 8;
        g = 8;
        b = 8;
      };
      crust = {
        r = 11;
        g = 11;
        b = 11;
      };
    };

  addHex = name: rgb @ {
    r,
    g,
    b,
  }: {
    inherit r g b;
    hex = colorToHex rgb;
  };

  darkColours = builtins.mapAttrs addHex americano;
  lightColours = builtins.mapAttrs addHex ctp.latte;
}
