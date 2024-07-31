{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./samba.nix
  ];

  # Bootloader configuration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Supported filesystems
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "2984c03b";
  boot.zfs.extraPools = [
    "poolparty"
  ];

  # Networking configuration
  networking.hostName = "mono";
  networking.networkmanager.enable = true;

  # Time and locale settings
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Xserver configuration
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Docker configuration
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # User configuration
  users.users.noah = {
    isNormalUser = true;
    description = "noah";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [ ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPFG6qV8qrY4103LSiNNwVhakQQxAC+r5ARLsUlETpTQ"
    ];
  };

  # SSH configuration
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  services.zfs = {
    autoScrub.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    zfs
    vim
    wget
    neofetch
    htop
    pastebinit
    git
  ];

  fileSystems."/mnt/pool" = {
    device = "LABEL=poolparty";
    fsType = "zfs";
    options = [ "nofail" ];
  };

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  system.stateVersion = "24.05";
}