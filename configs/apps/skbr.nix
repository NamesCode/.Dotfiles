{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = [pkgs.sketchybar];
  };
  launchd = {
    agents.sketchybar = {
      enable = true;
      config = {
        ProgramArguments = ["${lib.getExe pkgs.sketchybar}"];
        KeepAlive = true;
        RunAtLoad = true;
        ProcessType = "Interactive";
        Nice = -20;
      };
    };
  };
  xdg.configFile = {
    "sketchybar" = {
      source = ../../ext/sketchybar;
      recursive = true;
    };
  };
}
