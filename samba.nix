{ config, pkgs, ... }:

{

  # Ensure the share directory exists
  environment.etc."mnt/pool/share" = {
    text = "";
  };

  services.samba = {
    package = pkgs.samba4Full;
    enable = true;
    openFirewall = true;
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
