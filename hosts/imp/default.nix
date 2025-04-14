{ ... }:

{
	imports = [
		./hardware
		../common/grub.nix
		../common/gnome
		../common/steam.nix
		../common/fonts.nix
		../common/shell.nix
	];
	system.stateVersion = "24.11";
	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	networking.hostName = "imp";
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	services = {
		xserver = {
			enable = true;
			displayManager = {
				gdm.enable = true;
			};
			xkb = {
				layout = "us";
				variant = "";
			};
		};
		printing.enable = true;
	};
  users.users.sara = {
    isNormalUser = true;
    description = "Sara";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
