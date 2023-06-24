{pkgs, ...}: {
  home.packages = [pkgs.rustup pkgs.sccache pkgs.cargo-nextest];
  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
  };
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
