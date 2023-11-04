{
  # This has to be here since only home-manager has xdg access. If its in the darwin volumne it has no access to xdg.
  xdg.configFile."sketchybar" = {
    source = ../../ext/sketchybar;
    recursive = true;
  };
}
