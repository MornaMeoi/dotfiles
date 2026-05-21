{ pkgs, lib, config, ... }:

let
  cfg = config.services.claude-xray;

  # 🔹 ЗАПОЛНИ СВОИМИ ДАННЫМИ ИЗ vless:// ССЫЛКИ
  vlessConfig = {
    uuid = "";  # формат: 8-4-4-4-12
    server = "176.124.210.192";
    port = 443;
    path = "/api/v2/";
    host = "cdn-spb-16.uiu.fyi";
  };

  # Валидный JSON для Xray (без geo-зависимостей)
  xrayConfig = {
    log.loglevel = "warning";
    
    # Простой DNS — без сложных резолверов
    dns = {
      servers = [ "1.1.1.1" "8.8.8.8" ];
    };

    inbounds = [{
      port = 10808;
      listen = "127.0.0.1";
      protocol = "socks";
      settings = { auth = "noauth"; udp = true; };
      sniffing = { 
        enabled = true; 
        destOverride = [ "http" "tls" ]; 
        routeOnly = true;  # не менять IP на домен
      };
    }];

    outbounds = [
      # 🔥 VLESS прокси
      {
        protocol = "vless";
        settings = {
          vnext = [{
            address = vlessConfig.server;
            port = vlessConfig.port;
            users = [{ id = vlessConfig.uuid; encryption = "none"; }];
          }];
        };
        streamSettings = {
          network = "tcp";  # tcp+http работает везде
          tcpSettings = {
            header = {
              type = "http";
              request = {
                path = [ vlessConfig.path ];
                headers = { Host = [ vlessConfig.host ]; };
                version = "1.1";
                method = "GET";
              };
            };
          };
          security = "tls";
          tlsSettings = {
            serverName = vlessConfig.host;
            alpn = [ "h2" "http/1.1" ];
            allowInsecure = false;
          };
        };
        tag = "proxy-out";
      }
      # Прямой выход для всего остального
      { protocol = "freedom"; tag = "direct"; }
    ];

    # Маршрутизация: только Claude через прокси
    routing = {
      domainStrategy = "IPIfNonMatch";
      rules = [
        { 
          type = "field"; 
          domain = [ "domain:anthropic.com" "domain:claude.ai" ]; 
          outboundTag = "proxy-out"; 
        }
        { type = "field"; outboundTag = "direct"; }
      ];
    };
  };

  # Генерируем файл конфига в /nix/store
  configFile = pkgs.writeText "xray-claude.json" (builtins.toJSON xrayConfig);
in
{
  # Опция включения (стандартный паттерн NixOS)
  options.services.claude-xray.enable = lib.mkEnableOption "Xray proxy for Claude";

  config = lib.mkIf cfg.enable {
    # Только xray, без geo-пакетов
    environment.systemPackages = [ pkgs.xray ];

    # Ручной systemd-сервис
    systemd.services.xray-claude = {
      description = "Xray SOCKS5 proxy for Claude";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.xray}/bin/xray run -config ${configFile}";
        Restart = "on-failure";
        RestartSec = "3";
        
        # Безопасность (без CAP_NET_ADMIN, т.к. не используем TUN)
        DynamicUser = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        NoNewPrivileges = true;
      };
    };
  };
}