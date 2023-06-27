{
  description = "Name's Nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
    nekowinston-nur.url = "github:nekowinston/nur";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # is-lightmode = {
    #   url = "path:./scripts/is-lightmode";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nekowinston-nur,
    nur,
    darwin,
    ...
  } @ inputs: let
    machine = import ./machine.nix;
    # overlays = final: prev: {
    #   is-lightmode = inputs.is-lightmode.packages.${machine.system}.default;
    # };
    pkgs = import nixpkgs {
      system = ["aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux"];
    };
    overlays = [
      # nur overlay
      (final: prev: {
        nur = import nur {
          nurpkgs = prev;
          pkgs = prev;
          #       repoOverrides = {
          #         # other repo overrides
          #         nekowinston = nekowinston-nur.packages.${prev.system};
          #       };
        };
      })
      nekowinston-nur.overlays.default
    ];
  in {
    darwinConfigurations = {
      "NamesM2" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin
          home-manager.darwinModules.home-manager
          inputs.nekowinston-nur.darwinModules.default
          ({
            config,
            pkgs,
            ...
          }: {
            config = {
              nixpkgs.overlays = overlays;
              nixpkgs.config.allowUnfree = true;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                sharedModules = [
                  inputs.nekowinston-nur.homeManagerModules.default
                ];
                users.${machine.username}.imports = [./home.nix];
                extraSpecialArgs = {
                  inherit machine;
                };
              };
            };
          })
        ];
      };
    };
    homeConfigurations.${machine.username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix

        # ({config, ...}: {
        #   config = {
        #     nixpkgs.overlays = [overlays];
        #   };
        # })
      ];
      # overlays = [
      #   (final: prev: {
      #     nur = import nur {
      #       nurpkgs = prev;
      #       pkgs = prev;
      #                 };
      #   })
      # ];
      extraSpecialArgs = {
        inherit machine;
      };
    };
  };
}
