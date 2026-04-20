{ inputs, pkgs, ... }:

{
  imports = [ inputs.tg-ws-proxy.nixosModules.default ];

  services.tg-ws-proxy = {
    enable = true;
    # port = 1080;  # SOCKS5, по умолчанию 1080
  };
}