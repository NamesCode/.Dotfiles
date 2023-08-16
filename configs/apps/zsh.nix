{
  config,
  flakePath,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  zshPlugins = plugins: (map (plugin: rec {
      name = src.name;
      inherit (plugin) file src;
    })
    plugins);
in {
  programs = {
    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    fzf = {
      enable = true;
      colors = {
        fg = "#cdd6f4";
        "fg+" = "#cdd6f4";
        hl = "#f38ba8";
        "hl+" = "#f38ba8";
        header = "#ff69b4";
        info = "#cba6f7";
        marker = "#f5e0dc";
        pointer = "#f5e0dc";
        prompt = "#cba6f7";
        spinner = "#f5e0dc";
      };
      defaultOptions = ["--height=30%" "--layout=reverse" "--info=inline"];
    };

    lsd = {
      enable = true;
      enableAliases = true;
    };

    nix-index.enable = true;

    starship.enable = true;

    tealdeer = {
      enable = true;
      settings = {
        style = {
          description.foreground = "white";
          command_name.foreground = "green";
          example_text.foreground = "blue";
          example_code.foreground = "white";
          example_variable.foreground = "yellow";
        };
        updates.auto_update = true;
      };
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = false;

      # initExtra = let
      #   functionsDir = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}/functions";
      # in ''
      #   for script in "${functionsDir}"/**/*; do
      #     source "$script"
      #   done
      # '';
      envExtra = ''
        export LESSHISTFILE="-"
        export ZVM_INIT_MODE="sourcing"
        export ZVM_CURSOR_BLINKING_BEAM="1"
        export PATH=$PATH:/etc/profiles/per-user/Name/bin/
        export TERM=xterm
      '';

      dotDir = ".config/zsh";
      oh-my-zsh = {
        enable = true;
        plugins = [
          "colored-man-pages"
          "colorize"
          "docker"
          "docker-compose"
          "git"
          # "kubectl"
        ];
      };
      plugins = with pkgs; (zshPlugins [
        # {
        # src = zsh-vi-mode;
        # file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        # }
        {
          src = zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          src = zsh-fast-syntax-highlighting;
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        }
      ]);
      shellAliases = {
        # cat =
        # if isDarwin
        # then "bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo Catppuccin-mocha || echo Catppuccin-latte)"
        # else "bat";
        # switch between yubikeys for the same GPG key
        # switch_yubikeys = ''gpg-connect-agent "scd serialno" "learn --force" "/bye"'';
        tree = "lsd --tree";
      };
      history.path = "${config.xdg.configHome}/zsh/history";
    };
  };

  xdg.configFile."starship.toml" = {
    source = ../../ext/starship.toml;
  };
}
