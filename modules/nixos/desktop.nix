{ pkgs, ... }:

{
  services.xserver = {
    enable       = true;
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout  = "us,ru";
      options = "grp:alt_shift_toggle";
      variant = "";
    };
  };

  programs.hyprland.enable = true;

  xdg.portal = {
    enable       = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  environment.variables = {
    NIXOS_OZONE_WL               = "1";
    GBM_BACKEND                  = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME    = "nvidia";
    WLR_NO_HARDWARE_CURSORS      = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}