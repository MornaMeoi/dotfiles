{ config, pkgs, vars, ... }:

{
  home.username    = vars.user;
  home.homeDirectory = "/home/${vars.user}";
  home.stateVersion = "25.11";

  imports = [
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/vscode.nix
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
    gcc
    valgrind
    clang-tools
    gnumake
    cmake
    cppcheck
    docker-compose
    # Office
    libreoffice-qt6
    hunspell
    hunspellDicts.ru_RU
    hunspellDicts.en_US
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