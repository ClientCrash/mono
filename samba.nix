{ config, pkgs, ... }:

{
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      security = user
      #use sendfile = yes
      #max protocol = smb2
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      public = {
        path = "/poolparty/share";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";  # Disable guest access
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "noah";
        "force group" = "nogroup";
        "valid users" = "noah";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
