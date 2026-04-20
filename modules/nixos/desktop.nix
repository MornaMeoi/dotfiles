{ pkgs, inputs, ... }:

{
  services.xserver = {
    enable       = true;
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout  = "us";
      variant = "";
    };
  };

  services.displayManager.sddm.enable       = true;
  programs.hyprland.enable = true;

  xdg.portal = {
    enable       = true;
    extraPortals = [];
  };

  environment.variables = {
    NIXOS_OZONE_WL               = "1";
    GBM_BACKEND                  = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME    = "nvidia";
    WLR_NO_HARDWARE_CURSORS      = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}