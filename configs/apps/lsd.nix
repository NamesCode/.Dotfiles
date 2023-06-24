{lib, ...}: let
  colours = import ../../lib/colours.nix {inherit lib;};
  rgb = {
    r,
    g,
    b,
    ...
  }: [r g b];
  mkTheme = flavour:
    with flavour;
      builtins.toJSON {
        user = rgb rosewater;
        group = rgb flamingo;
        permission = {
          read = rgb green;
          write = rgb yellow;
          exec = rgb red;
          exec-sticky = rgb mauve;
          no-access = rgb maroon;
          octal = rgb subtext0;
          acl = rgb pink;
          context = rgb sky;
        };
        date = {
          hour-old = rgb text;
          day-old = rgb subtext1;
          older = rgb subtext0;
        };
        size = {
          none = rgb overlay2;
          small = rgb subtext0;
          medium = rgb subtext1;
          large = rgb text;
        };
        inode = {
          valid = rgb pink;
          invalid = rgb red;
        };
        links = {
          valid = rgb sapphire;
          invalid = rgb red;
        };
        tree-edge = rgb surface2;
      };
in {
  programs.lsd = {
    enable = true;
    enableAliases = true;
    settings = {
      blocks = ["permission" "user" "size" "date" "name"];
      date = "+%d/%m/%y %H:%M";
      size = "short";
      sorting.dir-grouping = "first";
      hyperlink = "auto";
      color.theme = "catppuccin-dark";
    };
  };

  xdg.configFile."lsd/themes/catppuccin-dark.yaml".text = mkTheme colours.darkColours;
  xdg.configFile."lsd/themes/catppuccin-light.yaml".text = mkTheme colours.lightColours;
}
