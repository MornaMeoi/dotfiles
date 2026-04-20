{ ... }:
{
  imports = [
    ./nix.nix
    ./boot.nix
    ./network.nix
    ./locale.nix
    ./hardware.nix
    ./desktop.nix
    ./audio.nix
    ./users.nix
    ./packages.nix
  ];
}