{ config, pkgs, vars, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name  = vars.gitName;
      user.email = vars.gitEmail;
      init.defaultBranch = "main";
    };
  };
}