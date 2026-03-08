{ config, pkgs, ... }:

{
  home.username = "mornameoi";
  home.homeDirectory = "/home/mornameoi";
  home.stateVersion = "25.11";

  imports = [
    ./programs/git.nix
    ./programs/fish.nix
    ./programs/vscode.nix
  ];

  # ── Пакеты пользователя ───────────────────────────────────────────────────
  home.packages = with pkgs; [
    # Инструменты разработки
    bat          # cat с подсветкой
    btop         # мониторинг ресурсов
    fd           # быстрый find
    fzf          # fuzzy finder
    gh           # GitHub CLI
    jq           # работа с JSON
    ripgrep      # быстрый grep
  ];

  # ── XDG директории ───────────────────────────────────────────────────────
  xdg.enable = true;

  # ── SSH ──────────────────────────────────────────────────────────────────
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
