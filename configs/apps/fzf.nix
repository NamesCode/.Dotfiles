{lib, ...}: let
  colours = (import ../../lib/colours.nix {inherit lib;}).darkColours;
in {
  programs.fzf = {
    enable = true;
    colors = {
      "bg+" = "-1";
      "fg+" = colours.text.hex;
      "hl+" = colours.yellow.hex;
      bg = "-1";
      fg = colours.text.hex;
      header = colours.pink.hex;
      hl = colours.yellow.hex;
      info = colours.pink.hex;
      marker = colours.rosewater.hex;
      pointer = colours.rosewater.hex;
      prompt = colours.pink.hex;
      spinner = colours.rosewater.hex;
      border = colours.pink.hex;
    };
    defaultOptions = [
      "--height 20%"
      "--border"
      "--reverse"
    ];
  };
}
