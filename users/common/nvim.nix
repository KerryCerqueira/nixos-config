{ pkgs, flakeInputs, ... }:

{
	programs.neovim = {
		enable = true;
		withRuby = true;
		withNodeJs= true;
		withPython3= true;
		viAlias = true;
		vimAlias = true;
		defaultEditor = true;
	};
	home.packages = with pkgs; [
		# nvim dependencies
		gnumake
		gcc
		git
		neovide
		xclip
		jdk
		fd
		ripgrep
		# secrets tools
		sops
		# LSPs
		lua-language-server
		jdt-language-server
		taplo
		pyright
		ruff
		texlab
		nil
		flakeInputs.hyprls.packages.${system}.default
		# tex
		texliveFull
		# python
		micromamba
		#rust
		rustup
	];
	home.file.".config/nvim/" = {
		source = "${flakeInputs.nvim-config}";
		recursive = true;
	};
}
