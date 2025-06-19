{ config, lib, flakeInputs, ... }:

{
	imports = [
		./bluetooth.nix
		./hardware-configuration.nix
		./sound.nix
	];
}
