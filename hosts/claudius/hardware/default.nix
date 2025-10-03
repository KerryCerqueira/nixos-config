{ flakeInputs, ... }:

{
	imports = [
		./bluetooth.nix
		./hardware-configuration.nix
		./sound.nix
		flakeInputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen2
	];
}
