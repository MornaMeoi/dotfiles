{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls   = "ls --color=auto";
      ll   = "ls -lah";
      cat  = "bat";
      grep = "rg";
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
