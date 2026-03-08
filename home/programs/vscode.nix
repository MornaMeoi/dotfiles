# home/programs/vscode.nix
{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions; [
      # Nix
      jnoortheen.nix-ide       # Nix IDE (языковой сервер)
      mkhl.direnv              # direnv интеграция

      # Git
      eamodio.gitlens          # расширенный git blame/история

      # Общее
      esbenp.prettier-vscode   # форматтер
      usernamehw.indent-rainbow # подсветка отступов
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
            "command" = [ "nixfmt-rfc-style" ]; # уже заменили nixpkgs-fmt
          };
        };
      };
    };
  };
}
