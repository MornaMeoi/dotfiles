{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable       = true;
  virtualisation.docker.enable  = true;

  environment.systemPackages = with pkgs; [
    xray
    nil
    nixfmt-rfc-style
    pciutils
    obsidian
  ];
}