{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "MornaMeoi";
    userEmail = "ваш@email.com";
    extraConfig.init.defaultBranch = "main";
  };
}