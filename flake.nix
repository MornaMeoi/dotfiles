{
  description = "mornameoi NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    tg-ws-proxy.url = "github:pialtor/tg-ws-proxy-flake";
    tg-ws-proxy.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, plasma-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    vars = {
      user     = "mornameoi";
      hostname = "nixos";
      dotfiles = "/home/mornameoi/dotfiles";
      gitName  = "MornaMeoi";
      gitEmail = "shurasick@mail.ru";
      editor   = "code --wait";
      browser  = "google-chrome";
    };
  in {
    nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit vars inputs; };
      modules = [
        ./hosts/nixos/configuration.nix
        ./modules/nixos
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs       = true;
          home-manager.useUserPackages     = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs    = { inherit vars; };
          home-manager.sharedModules       = [
            plasma-manager.homeModules.plasma-manager
          ];
          home-manager.users.${vars.user}  = import ./modules/home/default.nix;
        }
      ];
    };
  };
}