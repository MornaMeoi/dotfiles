{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos";
      rebuild-test = "sudo nixos-rebuild test --flake ~/dotfiles#nixos";
      ls   = "ls --color=auto";
      ll   = "ls -lah";
      # cat  = "bat";
      # grep = "rg";
      ".." = "cd ..";
    };
    shellInit = ''
      set -x EDITOR "code --wait"
    '';
  };

  programs.starship = {
    enable = true;         # красивый промпт, интегрируется с fish автоматически
    enableFishIntegration = true;
  };
}
