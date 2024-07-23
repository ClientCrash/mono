{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader configuration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Supported filesystems
  boot.supportedFilesystems = [ "btrfs" ];


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
  };

  # SSH configuration
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    btrfs-progs
    vim
    wget
    neofetch
    htop
    pastebinit
    git
  ];


  fileSystems."/mnt/pool" = {
    device = "LABEL=poolparty";
    fsType = "btrfs";
    options = [ "nofail" ];
  };

  system.stateVersion = "24.05";
}