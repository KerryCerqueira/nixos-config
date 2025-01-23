{ pkgs, flakeInputs, ... }:

{
	programs.neovim = {
		enable = true;
		package = pkgs.neovim-nightly;
		withRuby = true;
		withNodeJs= true;
		withPython3= true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		defaultEditor = true;
		extraLuaPackages = luaPkgs: with luaPkgs; [
			magick
		];
		extraPackages = let
			lsps = with pkgs; [
				lua-language-server
				jdt-language-server
				taplo
				pyright
				ruff
				texlab
				nil
				flakeInputs.hyprls.packages.${system}.default
			];
		in lsps;
		plugins = with pkgs.vimPlugins; [
			lazy-nvim
		];
		extraLuaConfig = builtins.readFile ./init.lua;
	};
}
