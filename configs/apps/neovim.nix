{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;

    package = pkgs.symlinkJoin {
      name = "neovim";
      paths = [pkgs.neovim-unwrapped];
      buildInputs = [pkgs.makeWrapper pkgs.gcc];
      postBuild = "wrapProgram $out/bin/nvim --prefix CC : ${pkgs.lib.getExe pkgs.gcc}";
    };

    extraPackages = with pkgs; [
      # external deps
      fd
      ripgrep

      # python
      black
      isort
      nodePackages.pyright

      # lua
      stylua
      lua-language-server
      luaPackages.tl
      luaPackages.teal-language-server

      # data
      taplo

      # go
      go
      delve
      ginkgo
      gofumpt
      gopls
      impl
      mockgen

      # webdev
      nodePackages."@astrojs/language-server"
      nodePackages."@tailwindcss/language-server"
      nodePackages.alex
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.graphql
      nodePackages.graphql-language-service-cli
      nodePackages.intelephense
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.svelte-language-server
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-json-languageserver-bin
      nodePackages.yaml-language-server
      yarn

      # rust
      cargo
      rust-analyzer
      rustc
      rustfmt

      # etc
      alejandra
      deno
      ltex-ls
      nil
      nodePackages.prettier
      proselint
      shellcheck
      shfmt
      tree-sitter
      # pkgs.nur.repos.nekowinston.jq-lsp
      # pkgs.nur.repos.nekowinston.helm-ls
      pkgs.nur.repos.bandithedoge.nodePackages.emmet-ls

      # nvim-spectre
      gnused
      (writeShellScriptBin "gsed" "exec ${gnused}/bin/sed")

      # needed for some plugin build steps
      gnumake
      unzip
    ];
  };

  xdg.configFile."nvim" = {
    source = ../../ext/neovim;
    recursive = true;
  };
}
