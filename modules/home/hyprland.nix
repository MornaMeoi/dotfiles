{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable  = true;

    settings = {
      monitor = ",preferred,auto,1";

      env = [
        "XCURSOR_SIZE,24"
      ];

      input = {
        kb_layout  = "us,ru";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        touchpad.natural_scroll = true;
      };

      general = {
        gaps_in    = 5;
        gaps_out   = 10;
        border_size = 2;
        layout     = "dwindle";
      };

      decoration.rounding = 8;

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Return, exec, kitty"
        "$mainMod, Q, killactive"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, E, exec, dolphin"
        "$mainMod, F, fullscreen"
        "$mainMod, V, togglefloating"

        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"
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
  ];
}