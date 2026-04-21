{ config, ... }:

{
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable     = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open               = true;
    nvidiaSettings     = true;
    package            = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.bluetooth = {
    enable       = true;
    powerOnBoot  = true;
  };

  services.blueman.enable = true;
}