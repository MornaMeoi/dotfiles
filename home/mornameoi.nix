{ config, pkgs, ... }:

{
  home.username = "mornameoi";
  home.homeDirectory = "/home/mornameoi";
  home.stateVersion = "25.11";

  imports = [
    ./programs/git.nix
    ./programs/fish.nix
  ];

  home.packages = with pkgs; [
    bat
    btop
    fd
    fzf
    gh
    google-chrome
    jq
    ripgrep
    tree
    vscode
    gcc
    valgrind
    clang-tools
    gnumake
    cmake
    cppcheck
    docker-compose
    # ── Office ────────────────────────────────────────────────────────────
    libreoffice-qt6         # нативная Qt6/Plasma 6 сборка
    hunspell                # движок проверки орфографии
    hunspellDicts.ru_RU     # русский словарь
    hunspellDicts.en_US     # английский словарь
  ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*".addKeysToAgent = "yes";
      "github.com".identityFile = "~/.ssh/id_ed25519";
    };
  };
}
