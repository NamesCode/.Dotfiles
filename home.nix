{
  pkgs,
  machine,
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

  home.packages = with pkgs; [
    alejandra
    htop
    yarn
    xz
    ffmpeg
    scrcpy
    gnupg
    fd
    gh
    just
    tree-sitter
    imagemagick
    openssh
    postgresql
    ripgrep
    scc
    unzip
    wget
    spicetify-cli
    android-tools
    rnix-lsp
    neofetch
    nodejs
    bash
    fira-code
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ];

  targets.genericLinux.enable = pkgs.stdenv.isLinux;

  xdg.configFile."nix/nix.conf".text = "experimental-features = nix-command flakes";

  imports =
    if pkgs.stdenv.isDarwin
    then import ./configs/macos.nix
    else import ./configs/linux.nix;
}
