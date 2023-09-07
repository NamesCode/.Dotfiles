{
  pkgs,
  config,
  lib,
  ...
}: let
  machine = import ../machine.nix;
in {
  services.nix-daemon.enable = true;
  users.users.${machine.username}.home = "/Users/${machine.username}";
  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ../ext/.skhdrc;
  };
  services.yabai = {
    enable = true;
    extraConfig = builtins.readFile ../ext/yabairc;
  };

  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = let
      skipSha = name: {
        inherit name;
        args = {require_sha = false;};
      };
      noQuarantine = name: {
        inherit name;
        args = {no_quarantine = true;};
      };
    in [
      "discord"
      "blender"
      "docker"
      "mullvadvpn"
      "utm"
      "maccy"
      "balenaetcher"
      (skipSha "spotify")
      "gimp"
      (noQuarantine "olive")
      "discord"
      "vlc"
      (noQuarantine "chiaki")
      "appcleaner"
      "mullvadvpn"
      "visual-studio-code"
      (noQuarantine "eloston-chromium")
      (noQuarantine "firefox")
      (noQuarantine "mutespotifyads")
    ];
    taps = ["homebrew/cask" "d12frosted/emacs-plus"];
    extraConfig = ''
      brew "emacs-plus@28", args:["with-imagemagick", "with-native-comp"]
    '';
  };
}
