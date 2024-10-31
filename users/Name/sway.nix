{config, pkgs, ...}: {
wayland.windowManager.sway = {
enable = true;
package = false;
config = {
assigns = {
"1: web" = [{ class="^Firefox$";}];
};
};
};
}
