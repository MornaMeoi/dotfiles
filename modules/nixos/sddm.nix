{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable    = true;
    wayland.enable = true;
    theme     = "catppuccin-mocha";
    package   = pkgs.kdePackages.sddm;
  };

  environment.systemPackages = [
    (pkgs.catppuccin-sddm.override {
      flavor  = "mocha";
      accent  = "blue";
      background = "${pkgs.nixos-artwork.wallpapers.simple-dark-gray}/share/backgrounds/nixos/nix-wallpaper-simple-dark-gray.png";
    })
  ];
}