{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ── Boot ──────────────────────────────────────────────────────────────────
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 5; # секунд до автозагрузки
    systemd-boot = {
      enable = true;
      configurationLimit = 5; # максимум 5 последних поколений в меню
      editor = false; # запретить редактирование параметров ядра при загрузке (безопаснее)
    };
  };

  # ── Nix Garbage Collector ─────────────────────────────────────────────────
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d"; # удалять генерации старше 14 дней
  };

  # ── Nix ───────────────────────────────────────────────────────────────────
  nix.settings = {
    auto-optimise-store = true; # дедупликация файлов в /nix/store
    experimental-features = [ "nix-command" "flakes" ];
  };

  # ── Networking ────────────────────────────────────────────────────────────
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    wireguard.enable = true;
  };

  # ── Locale & Timezone ─────────────────────────────────────────────────────
  time.timeZone = "Europe/Moscow";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS        = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT    = "ru_RU.UTF-8";
      LC_MONETARY       = "ru_RU.UTF-8";
      LC_NAME           = "ru_RU.UTF-8";
      LC_NUMERIC        = "ru_RU.UTF-8";
      LC_PAPER          = "ru_RU.UTF-8";
      LC_TELEPHONE      = "ru_RU.UTF-8";
      LC_TIME           = "ru_RU.UTF-8";
    };
  };

  # ── Hardware firmware ─────────────────────────────────────────────────────
  hardware.enableRedistributableFirmware = true; # MediaTek WiFi, AMD microcode и т.д.

  # ── Hardware ──────────────────────────────────────────────────────────────
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # нужно для Steam, Wine, игр через Proton
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true; # включает GUI-утилиту nvidia-settings и nvidia-smi
    package = config.boot.kernelPackages.nvidiaPackages.stable; # явно фиксируем ветку
  };

  # ── Display Server & Desktop ──────────────────────────────────────────────
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # ── Audio ─────────────────────────────────────────────────────────────────
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  # ── Bluetooth ─────────────────────────────────────────────────────────────
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # фикс off-blocked при загрузке
  };
  services.blueman.enable = true;

  # ── Printing ──────────────────────────────────────────────────────────────
  services.printing.enable = true;

  # ── Users ─────────────────────────────────────────────────────────────────
  users.users.mornameoi = {
    description = "MornaMeoi";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    isNormalUser = true;
    shell = pkgs.fish;
  };

  # ── Programs ──────────────────────────────────────────────────────────────
  programs = {
    direnv.enable = true; # автоматически добавляет хук в Fish
    fish.enable = true;
  };

  # ── System Packages ───────────────────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Nix tooling
    nil           # Language Server (замена rnix-lsp)
    nixfmt-rfc-style  # официальный форматтер (заменяет nixpkgs-fmt)

    # Libraries
    boost
    qt6.qtbase
    qt6.qtdeclarative

    # System utilities
    pciutils
    wireguard-tools
    telegram-desktop
  ];

  system.stateVersion = "25.11";
}
