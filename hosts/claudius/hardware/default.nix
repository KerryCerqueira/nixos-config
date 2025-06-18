{ config, lib, flakeInputs, ... }:

{
	imports = [
		./bluetooth.nix
		./hardware-configuration.nix
		./sound.nix
		flakeInputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen2
	];
	services.xserver.wacom.enable = lib.mkDefault config.services.xserver.enable;
	hardware.trackpoint.enable = lib.mkDefault true;
	hardware.trackpoint.emulateWheel = lib.mkDefault config.hardware.trackpoint.enable;
	hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
	hardware.sensor.iio.enable = true;
	security.rtkit.enable = true;
}
