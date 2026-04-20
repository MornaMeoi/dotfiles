{ pkgs, vars, ... }:

{
  users.users.${vars.user} = {
    description  = vars.gitName;
    extraGroups  = [ "networkmanager" "wheel" "docker" ];
    isNormalUser = true;
    shell        = pkgs.fish;
  };

  programs = {
    direnv.enable = true;
    fish.enable   = true;
  };
}