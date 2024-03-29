{
  config,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    #   package = pkgs.nur.repos.nekowinston.wezterm-nightly;
  };
  # disable the default config created by Home-Manager
  xdg.configFile."wezterm/wezterm.lua".enable = false;
  # and use my own config instead
  xdg.configFile."wezterm" = {
    source = ../../ext/wezterm;
    recursive = true;
  };
  programs.zsh.initExtra = ''
    if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
      TERM=xterm
      source ${config.programs.wezterm.package}/etc/profile.d/wezterm.sh
    fi
  '';
}
