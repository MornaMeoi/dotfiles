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
    telegram-desktop
    vscode
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
}
