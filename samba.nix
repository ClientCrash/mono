{ config, pkgs, ... }:

{
  services.samba = {
    enable = true;
    extraConfig = ''
      [pool]
      path = /mnt/pool/share
      browseable = yes
      writable = yes
      guest ok = no
      create mask = 0644
      directory mask = 0755
    '';
  };
}
