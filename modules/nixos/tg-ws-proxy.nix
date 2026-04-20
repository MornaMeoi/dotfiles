{ inputs, pkgs, ... }:

let
  tg-ws-proxy = inputs.tg-ws-proxy.packages.${pkgs.system}.default;
in
{
  systemd.services.tg-ws-proxy = {
    description = "TG WS Proxy";
    wantedBy    = [ "multi-user.target" ];
    after       = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${tg-ws-proxy}/bin/tg-ws-proxy";
      Restart   = "on-failure";
      DynamicUser = true;
    };
  };
}