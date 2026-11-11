{ config, lib, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda"; 

  networking.hostName = "nixos"; 

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";
  console.keyMap = "es";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    tcpdump
    tshark
    neovim
    git
    ethtool
  ];

  # SSH 
  services.openssh.enable = true;
  services.openssh.settings = {
    AllowAgentForwarding = true;
    LogLevel = "VERBOSE";
  };

  users.users.client = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  users.users.root.initialPassword = "nix";

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

