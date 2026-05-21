{ inputs, pkgs, ... }:

let
  tg-ws-proxy = inputs.tg-ws-proxy.packages.${pkgs.system}.default;
  tgSecret = "6f79dd178656d31f3b0ed94cc7bc1104";
in
{
  systemd.services.tg-ws-proxy = {
    description = "TG WS Proxy";
    wantedBy    = [ "multi-user.target" ];
    after       = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${tg-ws-proxy}/bin/tg-ws-proxy --secret ${tgSecret} --host 127.0.0.1 --port 1443";
      Restart   = "on-failure";
      DynamicUser = true;
    };
  };
}