{ pkgs, lib, config, ... }:

let
  cfg = config.services.claude-xray;

  vlessConfig = {
    uuid   = "";   # вставить из vless://
    server = "176.124.210.192";
    port   = 443;
    path   = "/api/v2/";
    sni    = "cdn-spb-16.uiu.fyi";
  };

  xrayConfig = {
    log.loglevel = "warning";

    inbounds = [{
      tag      = "socks-in";
      port     = 10808;
      listen   = "127.0.0.1";
      protocol = "socks";
      settings = { auth = "noauth"; udp = true; };
      sniffing = {
        enabled      = true;
        destOverride = [ "http" "tls" ];
        routeOnly    = true;
      };
    }];

    outbounds = [
      {
        tag      = "proxy-out";
        protocol = "vless";
        settings.vnext = [{
          address = vlessConfig.server;
          port    = vlessConfig.port;
          users   = [{ id = vlessConfig.uuid; encryption = "none"; }];
        }];
        streamSettings = {
          network  = "xhttp";
          security = "tls";

          xhttpSettings = {
            host = vlessConfig.sni;     # Host-header = SNI (в ссылке отдельного host= нет)
            path = vlessConfig.path;
            mode = "auto";
          };

          tlsSettings = {
            serverName    = vlessConfig.sni;
            alpn          = [ "h2" "http/1.1" ];
            fingerprint   = "random";   # uTLS, из fp=random
            allowInsecure = false;
          };
        };
      }
      { tag = "direct"; protocol = "freedom"; }
      { tag = "block";  protocol = "blackhole"; }
    ];

    routing = {
      domainStrategy = "IPIfNonMatch";
      rules = [
        {
          type        = "field";
          domain      = [ "domain:anthropic.com" "domain:claude.ai" ];
          outboundTag = "proxy-out";
        }
        { type = "field"; outboundTag = "direct"; network = "tcp,udp"; }
      ];
    };
  };

  configFile = pkgs.writeText "xray-claude.json" (builtins.toJSON xrayConfig);
in
{
  options.services.claude-xray.enable =
    lib.mkEnableOption "Xray SOCKS5 proxy for Claude (VLESS+XHTTP+TLS)";

  config = lib.mkIf cfg.enable {
    systemd.services.xray-claude = {
      description = "Xray SOCKS5 proxy for Claude (vni-hosting)";
      wantedBy    = [ "multi-user.target" ];
      after       = [ "network-online.target" ];
      wants       = [ "network-online.target" ];

      serviceConfig = {
        ExecStart           = "${pkgs.xray}/bin/xray run -config ${configFile}";
        Restart             = "on-failure";
        RestartSec          = "3";
        DynamicUser         = true;
        ProtectSystem       = "strict";
        ProtectHome         = true;
        NoNewPrivileges     = true;
        AmbientCapabilities = "";
      };
    };
  };
}