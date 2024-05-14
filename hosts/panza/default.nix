# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, configRoot, stateVersion, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];
# more hardware settings:
	fileSystems."/home" = {
		device = "/dev/disk/by-uuid/c67ed632-d694-454d-b39e-95322d23d0a5";
		fsType = "ext4";
	};

	nix.settings.experimental-features = ["nix-command" "flakes"];

# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.systemd-boot.configurationLimit = 1;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "panza"; # Define your hostname.
# networking.wireless.enable = true;  #Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
		networking.networkmanager.enable = true;

# Set your time zone.
	time.timeZone = "America/Toronto";

# Select internationalisation properties.
	i18n.defaultLocale = "en_CA.UTF-8";

# Enable the X11 windowing system.
	services.xserver.enable = true;

# Enable the GNOME Desktop Environment.
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;
	environment.gnome.excludePackages = ( with pkgs; [
			gnome-photos
			gnome-tour
	]) ++ (with pkgs.gnome; [
		gnome-music
		gnome-terminal
		epiphany # web browser
		geary # email reader
		evince # document viewer
		totem # video player
		tali # poker game
		iagno # go game
		hitori # sudoku game
		atomix # puzzle game
	]);
# Configure keymap in X11
	services.xserver = {
		xkb.layout = "us";
		xkb.variant = "";
	};

# Enable CUPS to print documents.
	services.printing.enable = true;

# hardware specific options
	hardware.sensor.iio.enable = true;
	services.fprintd.enable = true;
# Enable sound with pipewire.
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
# If you want to use JACK applications, uncomment this
#jack.enable = true;

# use the example session manager (no others are packaged yet so this is enabled by default,
# no need to redefine it in your config for now)
#media-session.enable = true;
	};

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.kerry = {
		isNormalUser = true;
		description = "Kerry Cerqueira";
		extraGroups = [ "networkmanager" "wheel" ];
	};

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		kitty
		easyeffects
	];
# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

	fonts.packages = with pkgs ; [
		iosevka
		(nerdfonts.override {fonts = ["Iosevka"];})
	];
	environment.variables = {
		ZDOTDIR = "$HOME/.config/zsh";
	};

	users.defaultUserShell = pkgs.zsh;
	programs = {
		zsh.enable = true;
		dconf.enable = true;
		firefox.enable = true;
		neovim = {
			enable = true;
			defaultEditor = true;
		};
		steam.enable = true;
	};
# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = stateVersion; # Did you read the comment?
}