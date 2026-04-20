{ config, pkgs, vars, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild      = "sudo nixos-rebuild switch --flake ${vars.dotfiles}#${vars.hostname}";
      rebuild-test = "sudo nixos-rebuild test --flake ${vars.dotfiles}#${vars.hostname}";
      ls  = "ls --color=auto";
      ll  = "ls -lah";
      cat  = "bat";
      grep = "rg";
      ".." = "cd ..";
    };
    shellInit = ''
      set -x EDITOR "${vars.editor}"
      set -x PKG_CONFIG_PATH /etc/profiles/per-user/${vars.user}/lib/pkgconfig
      set -x CPATH /etc/profiles/per-user/${vars.user}/include
      set -x LIBRARY_PATH /etc/profiles/per-user/${vars.user}/lib
      set -x LD_LIBRARY_PATH /etc/profiles/per-user/${vars.user}/lib
      # NVIDIA + Wayland + Electron
      set -x NIXOS_OZONE_WL 1
      set -x GBM_BACKEND nvidia-drm
      set -x __GLX_VENDOR_LIBRARY_NAME nvidia
      set -x WLR_NO_HARDWARE_CURSORS 1
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}