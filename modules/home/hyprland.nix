{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable  = true;

    settings = {
      monitor = ",preferred,auto,1";

      "exec-once" = [
        "dunst"
        "blueman-applet"
        "sleep 1 && hyprpaper"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland"
      ];

      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,24"
        "QT_STYLE_OVERRIDE,kvantum"
      ];

      input = {
        kb_layout  = "us,ru";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        touchpad.natural_scroll = true;
      };

      general = {
        gaps_in    = 0;
        gaps_out   = 0;
        border_size = 2;
        layout     = "dwindle";

        "col.active_border" = "rgba(89b4faee) rgba(cba6f7ee) 45deg";
        "col.inactive_border" = "rgba(313244aa)";
      };

      decoration.rounding = 8;

      "$mainMod" = "SUPER";
      "$up" = "W";
      "$down" = "S";
      "$left" = "A";
      "$right" = "D";

      bind = [
        "$mainMod, Return, exec, kitty"
        "$mainMod, Q, killactive"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, E, exec, dolphin"
        "$mainMod, F, fullscreen"
        "$mainMod, V, togglefloating"
        "$mainMod SHIFT, E, exec, hyprctl dispatch exit"

        "$mainMod, $left, movefocus, l"
        "$mainMod, $right, movefocus, r"
        "$mainMod, $up, movefocus, u"
        "$mainMod, $down, movefocus, d"
        "$mainMod SHIFT, $left, movewindow, l"
        "$mainMod SHIFT, $right, movewindow, r"
        "$mainMod SHIFT, $up, movewindow, u"
        "$mainMod SHIFT, $down, movewindow, d"
        "$mainMod CTRL, $left, resizeactive, -50 0"
        "$mainMod CTRL, $right, resizeactive,  50 0"
        "$mainMod CTRL, $up, resizeactive,  0 -50"
        "$mainMod CTRL, $down, resizeactive,  0  50"

        "$mainMod, Print, exec, grimblast copy screen"
        "$mainMod SHIFT, Print, exec, grimblast copy area"
        "$mainMod ALT, Print, exec, grimblast copy active"

        "$mainMod, G, exec, ~/dotfiles/scripts/record.sh"
      ]
      # Воркспейсы 1-9 через генерацию
      ++ (builtins.concatLists (builtins.genList (i:
        let ws = i + 1; in [
          "$mainMod, ${toString ws}, workspace, ${toString ws}"
          "$mainMod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
        ]
      ) 9));

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  home.packages = with pkgs; [
    kitty
    waybar
    rofi
    dunst
    hyprpaper
    grim
    slurp
    wl-clipboard
    hyprlock
    bibata-cursors
    kdePackages.dolphin
    kdePackages.kio-extras
  ];
}
