# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/52e55dc0-fd62-4463-aae6-315692666a33";
			fsType = "ext4";
		};
		"/boot" = {
			device = "/dev/disk/by-uuid/3874-7438";
			fsType = "vfat";
			options = [ "fmask=0022" "dmask=0022" ];
		};
		"/home" = {
			device = "/dev/disk/by-uuid/487d2b26-15d3-42b8-95b4-ccb27e24eec8";
			fsType = "ext4";
		};
		"/nix" = {
			device = "/dev/disk/by-uuid/ccec961c-815e-4d16-84ed-f0c9aa067675";
			fsType = "ext4";
		};
	};

	swapDevices = [
		{ device = "/dev/disk/by-uuid/a8db59dd-fc25-45af-b4a1-ff257158f600"; }
	];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
