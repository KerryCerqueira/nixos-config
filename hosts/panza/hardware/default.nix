{ config, lib, ... }:

{
	imports = [
		./hardware-configuration.nix
		./sound.nix
		./gpu.nix
		./bluetooth.nix
	];
	fileSystems."/home" = {
		device = "/dev/disk/by-uuid/c67ed632-d694-454d-b39e-95322d23d0a5";
		fsType = "ext4";
	};
	services.xserver.wacom.enable = lib.mkDefault config.services.xserver.enable;
	hardware.trackpoint.enable = lib.mkDefault true;
	hardware.trackpoint.emulateWheel = lib.mkDefault config.hardware.trackpoint.enable;
	hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
	hardware.sensor.iio.enable = true;
	security.rtkit.enable = true;
	powerManagement.enable = true;
	powerManagement.powertop.enable = true;
	services.thermald.enable = true;
	services.power-profiles-daemon.enable = true;
}
