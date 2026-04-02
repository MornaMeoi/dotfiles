{ config, pkgs, vars, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ── Boot ──────────────────────────────────────────────────────────────────
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 5;
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
      editor = false;
    };
  };

  # ── Nix ───────────────────────────────────────────────────────────────────
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  # ── Networking ────────────────────────────────────────────────────────────
  networking = {
    hostName = vars.hostname;   # ← из vars
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

  # ── Hardware ──────────────────────────────────────────────────────────────
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
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
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # ── Printing ──────────────────────────────────────────────────────────────
  services.printing.enable = true;

  # ── Flatpak ───────────────────────────────────────────────────────────────
  services.flatpak.enable = true;

  # ── Docker ────────────────────────────────────────────────────────────────
  virtualisation.docker.enable = true;

  # ── Users ─────────────────────────────────────────────────────────────────
  users.users.${vars.user} = {  # ← из vars
    description = vars.gitName;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    isNormalUser = true;
    shell = pkgs.fish;
  };

  # ── Programs ──────────────────────────────────────────────────────────────
  programs = {
    direnv.enable = true;
    fish.enable = true;
  };

  # ── System Packages ───────────────────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    nil
    nixfmt-rfc-style
    boost
    qt6.qtbase
    qt6.qtdeclarative
    pciutils
    wireguard-tools
    zapret
  ];

  system.stateVersion = "25.11";
}