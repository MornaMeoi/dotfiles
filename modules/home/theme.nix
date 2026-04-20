{ pkgs, ... }:
let
  catppuccinName = "Catppuccin-Mocha-Standard-Blue-Dark";
  catppuccin = pkgs.catppuccin-gtk.override {
    accents = [ "blue" ];
    size    = "standard";
    tweaks  = [ "normal" ];
    variant = "mocha";
  };
in
{
  gtk = {
    enable = true;
    theme = {
      name    = catppuccinName;
      package = catppuccin;
    };
    iconTheme = {
      name    = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name    = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size    = 24;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme    = catppuccinName;
      icon-theme   = "Papirus-Dark";
      cursor-theme = "Bibata-Modern-Classic";
      cursor-size  = 24;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  home.packages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
    catppuccin-kvantum
  ];

  home.file.".config/Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Mocha-Blue
  '';
}