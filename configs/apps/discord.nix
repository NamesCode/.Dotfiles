{pkgs, ...}: {
  home.packages = [(pkgs.discord.override {withOpenASAR = true;})];
}
