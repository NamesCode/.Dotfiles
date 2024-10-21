{
  description = "Name's Nix system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "aarch64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
    };
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    nixosConfigurations."navi" = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit system;};
      modules = [./systems/navi/configuration.nix inputs.home-manager.nixosModules.home-manager];
    };
  };
}
