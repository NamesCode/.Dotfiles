{pkgs, ...}: {
  programs.yabai = {
    enable = true;
    package = pkgs.nur.repos.nekowinston-nur.yabai;

    xdg.configFile."yabai" = {
      source = ../../ext/yabai;
      recursive = true;
    };
  };
}
