{ vars, ... }:

{
  networking = {
    hostName             = vars.hostname;
    networkmanager.enable = true;
    wireguard.enable     = true;
    networkmanager.dns   = "systemd-resolved";
  };

  services.resolved = {
    enable      = true;
    dnssec      = "false";
    dnsovertls  = "opportunistic";
    extraConfig = ''
      DNS=1.1.1.1#cloudflare-dns.com 8.8.8.8#dns.google
      FallbackDNS=9.9.9.9#dns.quad9.net
    '';
  };

  services.zapret = {
    enable = true;
    params = [
      "--filter-tcp=443"
      "--dpi-desync=multidisorder"
      "--dpi-desync-split-pos=2"
      "--dpi-desync-ttl=1"
    ];
  };
}