{ config, lib, pkgs, ... }:

{  xdg.configFile."doom" = {
    source = ../../ext/doom;
    recursive = true;
  };
}
