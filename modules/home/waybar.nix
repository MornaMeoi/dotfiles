{ ... }:
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer  = "top";
        position = "top";
        height = 30;

        modules-left   = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right  = [ "pulseaudio" "network" "cpu" "memory" "battery" "tray" ];

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
        };

        clock = {
          format = "{:%H:%M  %d.%m.%Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
        };

        cpu = {
          format = "CPU {usage}%";
          interval = 2;
        };

        memory = {
          format = "RAM {}%";
          interval = 2;
        };

        pulseaudio = {
          format = "VOL {volume}%";
          format-muted = "MUTE";
          on-click = "pavucontrol";
        };

        network = {
          format-wifi      = "  {signalStrength}%";
          format-ethernet  = "ETH";
          format-disconnected = "OFFLINE";
        };

        battery = {
          format = "BAT {capacity}%";
          format-charging = "CHR {capacity}%";
          states = { warning = 30; critical = 15; };
        };

        tray.spacing = 10;
      };
    };

    style = ''
      * {
        font-family: JetBrains Mono, monospace;
        font-size: 13px;
      }
      window#waybar {
        background: rgba(20, 20, 20, 0.9);
        color: #ffffff;
      }
      #workspaces button {
        padding: 0 8px;
        color: #888888;
      }
      #workspaces button.active {
        color: #ffffff;
        border-bottom: 2px solid #ffffff;
      }
      #clock, #cpu, #memory, #pulseaudio, #network, #battery {
        padding: 0 10px;
        color: #cccccc;
      }
    '';
  };
}