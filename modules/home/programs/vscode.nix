{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      mkhl.direnv
      eamodio.gitlens
      esbenp.prettier-vscode
      usernamehw.indent-rainbow
    ];

    userSettings = {
      "security.workspace.trust.untrustedFiles" = "open";
      "editor.tabSize" = 2;
      "files.autoSave" = "onFocusChange";
      "nix.enableLanguageServer" = true;
      "nix.serverName" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixfmt-rfc-style" ];
          };
        };
      };
    };
  };
}