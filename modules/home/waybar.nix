{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    settings = {
      mainBar = {
        layer    = "top";
        position = "top";
        height   = 32;
        spacing  = 4;

        modules-left   = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right  = [
          "cpu" "memory" "disk"
          "pulseaudio"
          "network"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
          sort-by-number = true;
        };

        "hyprland/window" = {
          format = "{title}";
          max-length = 60;
        };

        clock = {
          format = " {:%H:%M}";
          format-alt = " {:%d.%m.%Y %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        cpu = {
          format = " {usage}%";
          interval = 2;
          on-click = "kitty btop";
        };

        memory = {
          format = " {used:0.1f}G";
          interval = 5;
        };

        disk = {
          format = " {free}";
          path = "/";
          interval = 30;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰸈 muted";
          format-icons.default = [ "󰕿" "󰖀" "󰕾" ];
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-click-right = "pavucontrol";
        };

        network = {
          format-wifi     = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀 {ipaddr}";
          format-disconnected = "󰤭 offline";
          tooltip-format  = "{ifname}: {ipaddr}\n{gwaddr}";
        };

        tray = {
          spacing = 8;
          icon-size = 16;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(20, 20, 28, 0.92);
        color: #cdd6f4;
        border-bottom: 2px solid rgba(137, 180, 250, 0.3);
      }

      #workspaces button {
        padding: 0 10px;
        color: #585b70;
        background: transparent;
        border: none;
        border-radius: 0;
      }

      #workspaces button.active {
        color: #cdd6f4;
        border-bottom: 2px solid #89b4fa;
      }

      #workspaces button:hover {
        background: rgba(137, 180, 250, 0.1);
        color: #cdd6f4;
      }

      #window {
        color: #a6adc8;
        padding: 0 10px;
      }

      #clock {
        color: #89b4fa;
        font-weight: bold;
        padding: 0 12px;
      }

      #cpu    { color: #a6e3a1; padding: 0 8px; }
      #memory { color: #fab387; padding: 0 8px; }
      #disk   { color: #f38ba8; padding: 0 8px; }

      #pulseaudio        { color: #cba6f7; padding: 0 8px; }
      #pulseaudio.muted  { color: #585b70; }

      #network              { color: #89dceb; padding: 0 8px; }
      #network.disconnected { color: #f38ba8; }

      #tray { padding: 0 8px; }
    '';
  };
}