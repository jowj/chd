# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
  stable = import <nixos-stable> {};
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nix-ling"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0f1.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "fira-code";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "US/Central";
  # nixpkgs.config.allowBroken = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
	# build shit
	autoconf
	yarn
	automake
	gnumake
	wget
        gcc-arm-embedded
	xorg.libX11
	vim
	konsole
	# jlj utils
	ansible
	python38
	python38Packages.pip
	python38Packages.setuptools
	syncthing-gtk
	bitwarden
	chromium
	firefox
	next
	emacs
	zeal
	git
	keychain
	next
	os-prober
	breeze-grub
	grub2_efi
	lsof
	gnupg
	wireguard
	gcc8
	dfu-util
	scrot
	qbittorrent
	appimage-run
	fuse
	obs-studio
	# jlj sound
	pavucontrol
	# jlj comms
	element-desktop
	slack
	discord
	konversation
	signal-desktop
	newsflash # same maker as feedreader, newer, less features, actively maintained.
	zoom-us
	jitsi-meet-electron
	gnome3.evolution
	# jlj de
	acpi
	awesome
	gnome3.networkmanagerapplet
	arc-icon-theme	
	rofi
	i3lock
	vlc
	gnome3.gnome-tweaks
	gnome3.adwaita-icon-theme
	gnome-breeze
	# espanso # text expander
	xclip # c&p from cli / required for espanso
	libnotify # required for espanso
	# jlj games
	lutris
	steam
	vulkan-tools
  ];

  fonts.fonts = with pkgs; [
	noto-fonts
  	noto-fonts-cjk
  	noto-fonts-emoji
  	liberation_ttf
  	fira-code
	fira-code-symbols
	mplus-outline-fonts
  	dina-font
  	proggyfonts
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  # List services that you want to enable:
  # configure gnome environment for use outside of gnome.
  services.xserver.desktopManager.gnome3.enable = true;
  programs.dconf.enable = true;
  services.gnome3.evolution-data-server.enable = true;
  services.gnome3.gnome-online-accounts.enable = true;
  services.gnome3.gnome-keyring.enable = true;


  # enable espanso globally:
  services.espanso.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;    ## If compatibility with 32-bit applications is desired. games need this.

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.displayManager.startx.enable = true;

  # Enable vulkan support
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  programs.qt5ct.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.josiah = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "sound" "video"]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

