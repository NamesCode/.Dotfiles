{config, ...}: {
  home.file."Brewfile".source = config.lib.file.mkOutOfStoreSymlink ../../ext/Brewfile;
  home.sessionPath = [
    "/usr/local/sbin"
    "/opt/homebrew/bin"
  ];
}
