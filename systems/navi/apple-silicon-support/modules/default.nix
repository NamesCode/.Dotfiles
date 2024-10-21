{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./kernel ./mesa ./peripheral-firmware ./boot-m1n1 ./sound];

  config = let
    cfg = config.hardware.asahi;
  in
    lib.mkIf cfg.enable {
      nixpkgs.overlays = lib.mkBefore [cfg.overlay];

      hardware.asahi.pkgs =
        if cfg.pkgsSystem != "aarch64-linux"
        then
          import (pkgs.path) {
            crossSystem.system = "aarch64-linux";
            localSystem.system = cfg.pkgsSystem;
            overlays = [cfg.overlay];
          }
        else pkgs;
    };

  options.hardware.asahi = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Enable the basic Asahi Linux components, such as kernel and boot setup.
      '';
    };

    pkgsSystem = lib.mkOption {
      type = lib.types.str;
      default = "aarch64-linux";
      description = ''
        System architecture that should be used to build the major Asahi
        packages, if not the default aarch64-linux. This allows installing from
        a cross-built ISO without rebuilding them during installation.
      '';
    };

    pkgs = lib.mkOption {
      type = lib.types.raw;
      description = ''
        Package set used to build the major Asahi packages. Defaults to the
        ambient set if not cross-built, otherwise re-imports the ambient set
        with the system defined by `hardware.asahi.pkgsSystem`.
      '';
    };

    overlay = lib.mkOption {
      type = lib.mkOptionType {
        name = "nixpkgs-overlay";
        description = "nixpkgs overlay";
        check = lib.isFunction;
        merge = lib.mergeOneOption;
      };
      default = import ../packages/overlay.nix;
      defaultText = "overlay provided with the module";
      description = ''
        The nixpkgs overlay for asahi packages.
      '';
    };
  };
}
