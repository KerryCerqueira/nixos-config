{ flakeInputs, ... }:

{
	imports = [
		flakeInputs.nvim-config.homeManagerModules.nvim-config
		flakeInputs.shell-config.homeManagerModules.shell-config
	];
	programs.home-manager.enable = true;
	home = {
		username = "kerry";
		homeDirectory = "/home/kerry";
	};
}
