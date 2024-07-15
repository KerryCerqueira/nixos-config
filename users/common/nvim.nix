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
		nodePackages_latest.pyright
		ruff-lsp
		texlab
		nil
		# tex
		texliveFull
		# python
		micromamba
		#rust
		rustup
	];
	home.file.".config/nvim/" = {
		source = "${inputs.nvim-config}";
		recursive = true;
	};
}
