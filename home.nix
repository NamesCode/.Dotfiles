{
  pkgs,
  machine,
  outputs,
  ...
}: let
  homeRoot =
    if pkgs.stdenv.isDarwin
    then "/Users"
    else "/home";
in {
  home.username = machine.username;
  home.homeDirectory = "${homeRoot}/${machine.username}";

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  programs.zsh.enable = true;

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.packages = builtins.trace "home package" [
    pkgs.alejandra
    pkgs.htop
    pkgs.yarn
    pkgs.xz
    pkgs.ffmpeg
    pkgs.scrcpy
    pkgs.gnupg
    pkgs.fd
    pkgs.gh
    pkgs.just
    pkgs.tree-sitter
    pkgs.imagemagick
    pkgs.openssh
    pkgs.postgresql
    pkgs.ripgrep
    pkgs.scc
    pkgs.unzip
    pkgs.wget
    pkgs.spicetify-cli
    pkgs.android-tools
    pkgs.rnix-lsp
    pkgs.neofetch
    pkgs.vim
    pkgs.nodejs
    pkgs.bash
    pkgs.fira-code
    # pkgs.(nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ];

  targets.genericLinux.enable = pkgs.stdenv.isLinux;

  xdg.configFile."nix/nix.conf".text = "experimental-features = nix-command flakes";

  imports = import machine.configs;
}
