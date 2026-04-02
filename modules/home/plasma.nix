{ config, pkgs, vars, ... }:

{
  # ── Пакеты для темы ───────────────────────────────────────────────────────
  home.packages = with pkgs; [
    catppuccin-kde           # тема оформления
    catppuccin-cursors       # курсор
    papirus-icon-theme       # иконки (есть Dark вариант)
    kdePackages.qtstyleplugin-kvantum  # Kvantum — движок тем Qt
  ];

  programs.plasma = {
    enable = true;

    # ── Внешний вид ───────────────────────────────────────────────────────
    workspace = {
      lookAndFeel    = "org.kde.breezedark.desktop";
      colorScheme    = "CatppuccinMochaTeal";   # тёмный с циановым акцентом
      cursorTheme    = "Catppuccin-Mocha-Dark-Cursors";
      iconTheme      = "Papirus-Dark";
      # Положи любой Lain/Matrix обой в ~/Pictures/wallpaper.png
      wallpaper      = "/home/${vars.user}/Pictures/wallpaper.png";
    };

    # ── Шрифты ────────────────────────────────────────────────────────────
    fonts = {
      general = {
        family = "JetBrains Mono";
        pointSize = 10;
      };
      fixedWidth = {
        family = "JetBrains Mono";
        pointSize = 10;
      };
      small = {
        family = "JetBrains Mono";
        pointSize = 8;
      };
    };

    # ── Панель ────────────────────────────────────────────────────────────
    panels = [
      {
        location = "bottom";
        height = 44;
        floating = true;   # плавающая панель — выглядит современно
        widgets = [
          # Лаунчер
          {
            kickoff = {
              icon = "nix-snowflake-white";
            };
          }
          # Пейджер рабочих столов
          "org.kde.plasma.pager"
          # Таскбар
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.konsole.desktop"
                "applications:code.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:google-chrome.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          # Системный монитор — CPU + RAM + Network в одном виджете
          {
            systemMonitor = {
              title = "Resources";
              displayStyle = "org.kde.ksysguard.barchart";
              sensors = [
                {
                  name = "cpu/all/usage";
                  color = "23d18b";    # зелёный фосфор
                  label = "CPU";
                }
                {
                  name = "memory/physical/usedPercent";
                  color = "89b4fa";    # синий
                  label = "RAM";
                }
                {
                  name = "network/all/totalDataRate";
                  color = "cba6f7";    # фиолетовый
                  label = "NET";
                }
              ];
            };
          }
          # Трей
          {
            systemTray = {
              icons.scaleToFit = true;
              items = {
                showAll = false;
                shown = [
                  "org.kde.plasma.battery"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.bluetooth"
                ];
              };
            };
          }
          # Часы
          {
            digitalClock = {
              date.enable    = true;
              date.format    = "shortDate";
              time.format    = "24h";
              calendar.firstDayOfWeek = "monday";
            };
          }
        ];
      }
    ];

    # ── KWin эффекты ─────────────────────────────────────────────────────
    kwin = {
      effects = {
        blur.enable              = true;    # размытие под окнами
        desktopSwitching.animation = "slide";
        minimization.animation   = "magiclamp";  # джинн при минимизации
        shakeCursor.enable       = false;
        wobblyWindows.enable     = true;    # покачивание окон — кайф
      };
      virtualDesktops = {
        number = 4;
        rows   = 1;
      };
    };

    # ── Поведение окон ────────────────────────────────────────────────────
    windows = {
      allowWindowsToRememberPositions = true;
    };

    # ── Горячие клавиши ───────────────────────────────────────────────────
    shortcuts = {
      "kwin"."Switch to Desktop 1" = "Meta+1";
      "kwin"."Switch to Desktop 2" = "Meta+2";
      "kwin"."Switch to Desktop 3" = "Meta+3";
      "kwin"."Switch to Desktop 4" = "Meta+4";
      "kwin"."Window to Desktop 1" = "Meta+Shift+1";
      "kwin"."Window to Desktop 2" = "Meta+Shift+2";
      "kwin"."Window to Desktop 3" = "Meta+Shift+3";
      "kwin"."Window to Desktop 4" = "Meta+Shift+4";
      "kwin"."Kill Window"          = "Meta+Shift+Q";
      "kwin"."Window Maximize"      = "Meta+Up";
      "kwin"."Window Minimize"      = "Meta+Down";
      "org.kde.krunner.desktop"."_launch" = "Meta+Space";
    };

    # ── Сырые KDE конфиги (то, что не покрывает plasma-manager) ──────────
    configFile = {
      # Уменьшить скорость анимаций (0.5 = вдвое быстрее)
      "kdeglobals"."KDE"."AnimationDurationFactor" = "0.5";
      # Одиночный клик открывает файлы (как macOS/современные DE)
      "kdeglobals"."KDE"."SingleClick" = "false";
      # Тема Kvantum
      "~/.config/Kvantum/kvantum.kvconfig"."General"."theme" = "catppuccin-mocha-teal";
    };
  };
}