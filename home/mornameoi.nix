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
    vscode
  ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
