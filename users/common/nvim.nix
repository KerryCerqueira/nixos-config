{ pkgs, inputs, ... }:

{
	programs.neovim = {
		enable = true;
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
		ruff-lsp
		texlab
		nil
		inputs.hyprls.packages.${system}.default
		# tex
		texliveFull
		# python
		micromamba
		#rust
		rustup
		# node
		nodejs
	];
	home.file.".config/nvim/" = {
		source = "${inputs.nvim-config}";
		recursive = true;
	};
}
