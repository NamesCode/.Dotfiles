{
  config,
  pkgs,
  lib,
  ...
}: {
  services.nix-daemon.enable = true;
  users.users.Name.home = "/Users/Name";
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
      "docker"
      "mullvadvpn"
      "utm"
      "maccy"
      "balenaetcher"
      (skipSha "spotify")
      "gimp"
      "olive"
      "discord"
      "vlc"
      "appcleaner"
      "mullvadvpn"
      (noQuarantine "firefox")
      (noQuarantine "mutespotifyads")
    ];
    taps = ["homebrew/cask" "d12frosted/emacs-plus"];
    extraConfig = ''
      brew "emacs-plus@28", args:["with-imagemagick", "with-native-comp"]
    '';
  };
}
