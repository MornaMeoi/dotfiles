{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "MornaMeoi";
      user.email = "shurasick@mail.ru";
      init.defaultBranch = "main";
    };
  };
}