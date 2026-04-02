{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    package = pkgs.vscode;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        mkhl.direnv
        eamodio.gitlens
        esbenp.prettier-vscode
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name      = "indent-rainbow";
          publisher = "oderwat";
          version   = "8.3.1";
          sha256    = "sha256-dOicya0B2sriTcDSdCyhtp0Mcx5b6TUaFKVb0YU3jUc=";
        }
      ];

      userSettings = {
        "security.workspace.trust.untrustedFiles" = "open";
        "editor.tabSize" = 2;
        "files.autoSave" = "onFocusChange";
        "nix.enableLanguageServer" = true;
        "nix.serverName" = "nil";
        "nix.serverSettings"."nil"."formatting"."command" = [ "nixfmt-rfc-style" ];
      };
    };
  };
}