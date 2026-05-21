{ vars, ... }:

{
  networking = {
    hostName             = vars.hostname;
    networkmanager.enable = true;
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
    whitelist = [
      # YouTube / Google Video
      "youtube.com"
      "*.youtube.com"
      "googlevideo.com"
      "*.googlevideo.com"
      "ggpht.com"
      "*.ggpht.com"
      "ytimg.com"
      "*.ytimg.com"
      
      # Discord
      "discord.com"
      "*.discord.com"
      "discord.gg"
      "*.discord.gg"
      "cdn.discordapp.com"
      "gateway.discord.gg"
      
      # PornHub
      "pornhub.com"
      "*.pornhub.com"
      "phncdn.com"
      "*.phncdn.com"
      
      # Rutracker
      "rutracker.org"
      "*.rutracker.org"
      "rutracker.net"
      "*.rutracker.net"
      
      # ImHentai
      "imhentai.xxxx"
      "*.imhentai.xxxx"
    ];
    params = [
      "--filter-tcp=443"
      "--dpi-desync=multidisorder"
      "--dpi-desync-split-pos=2"
      "--dpi-desync-ttl=1"
    ];
  };
  services.claude-xray.enable = true;
}