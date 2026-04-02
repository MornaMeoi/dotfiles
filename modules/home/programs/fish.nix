{ config, pkgs, vars, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild      = "sudo nixos-rebuild switch --flake ${vars.dotfiles}#${vars.hostname}";
      rebuild-test = "sudo nixos-rebuild test --flake ${vars.dotfiles}#${vars.hostname}";
      ls  = "ls --color=auto";
      ll  = "ls -lah";
      cat  = "bat";
      grep = "rg";
      ".." = "cd ..";
    };
    shellInit = ''
      set -x EDITOR "${vars.editor}"
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}