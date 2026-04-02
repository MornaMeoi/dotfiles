{
  description = "mornameoi NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
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
      specialArgs = { inherit vars; };          # доступно в configuration.nix и всех NixOS-модулях
      modules = [
        ./hosts/nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs    = true;
          home-manager.useUserPackages  = true;
          home-manager.extraSpecialArgs = { inherit vars; }; # доступно во всех HM-модулях
          home-manager.users.${vars.user} = import ./modules/home/default.nix;
        }
      ];
    };
  };
}