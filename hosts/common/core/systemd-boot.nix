{ ... }:

{
	boot.loader.systemd-boot.enable = true;
	boot.loader.systemd-boot.configurationLimit = 2;
	boot.loader.efi.canTouchEfiVariables = true;
}
