# THIS CONFIG IS INTENDED TO BE USED TO SETUP THE DRIVES AND SO ON BEFORE LOADING THE MAIN CONFIG
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader configuration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Supported filesystems
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "2984c03b";

  # Networking configuration
  networking.hostName = "mono-setup";
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

  # User configuration
  users.users.noah = {
    isNormalUser = true;
    description = "noah";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEi5tcWoKorSEvEqYw4Z+VWXntuqc9HxVybX4ZwmraOB"
    ];
  };

  # SSH configuration
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
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

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  system.stateVersion = "24.05";
}