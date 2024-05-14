# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];
	system.stateVersion = "23.11";
	nix.settings.experimental-features = ["nix-command" "flakes"];
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.configurationLimit = 1;
	networking.hostName = "potato";
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	services.xserver.enable = true;
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;
	services.xserver.xkb = {
		layout = "ca";
		variant = "";
	};
	services.printing.enable = true;
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};
	users.users = {
		kerry = {
			isNormalUser = true;
			description = "Kerry";
			extraGroups = [ "networkmanager" "wheel" ];
		};
		erika = {
			isNormalUser = true;
			description = "Erika";
			extraGroups = [ "networkmanager" "wheel" ];
		};
	};

	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = with pkgs; [
		kitty
		easyeffects
	];
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
		neovim = {
			enable = true;
			defaultEditor = true;
		};
		steam.enable = true;
	};
}
