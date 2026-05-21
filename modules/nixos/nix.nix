{ ... }:

{
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 7d";
  };

  nix.settings = {
    auto-optimise-store      = true;
    experimental-features    = [ "nix-command" "flakes" ];
    trusted-users            = [ "root" "@wheel" ];
    substituters             = [
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    accept-flake-config = false;
  };
}