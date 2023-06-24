{pkgs, ...}: let
  pip-packages = ps:
    with ps; [
      catppuccin
      cookiecutter
      ipython
      requests
      rich
    ];
in {
  home.packages = [
    (pkgs.python311.withPackages pip-packages)
    pkgs.poetry
  ];

  home.file.".ipython/profile_default/ipython_config.py".text = ''
    from pygments.styles import get_style_by_name
    c = get_config()
    c.TerminalInteractiveShell.highlighting_style = get_style_by_name("catppuccin-mocha")
  '';

  home.sessionVariables = {
    PYTHONUSERBASE = "$HOME/.local";
  };
}
