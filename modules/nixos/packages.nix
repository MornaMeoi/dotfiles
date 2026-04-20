{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable       = true;
  virtualisation.docker.enable  = true;

  environment.systemPackages = with pkgs; [
    nil
    nixfmt-rfc-style
    pciutils
    wireguard-tools
    obsidian
  ];
}