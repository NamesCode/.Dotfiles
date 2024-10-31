{
  config,
  pkgs,
  ...
}:
{
  # Setup waybar
  programs.waybar = {
    enable = true;
  };
}
