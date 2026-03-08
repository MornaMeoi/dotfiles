{
  description = "mornameoi NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs"; # один nixpkgs на всё
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations = {

      # Текущий десктоп
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;    # один pkgs на систему и HM
            home-manager.useUserPackages = true;  # пакеты HM → users.users
            home-manager.users.mornameoi = import ./home/mornameoi.nix;
          }
        ];
      };

      # Будущий ноутбук — подключает тот же home.nix
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mornameoi = import ./home/mornameoi.nix;
          }
        ];
      };

    };
  };
}
