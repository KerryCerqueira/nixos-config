{ pkgs, inputs, ... }:
let
	root = inputs.self;
in {
	home.packages = with pkgs; [
		zsh
		kitty
		antidote
		ranger
		btop
		fzf
		atuin
		eza
		tldr
		dust
		xplr
		fd
		ripgrep
		bat
		bat-extras.batman
		bat-extras.batgrep
		bat-extras.batdiff
	];
	home.file = {
		".local/share/zsh/antidote/" = {
			source = "${pkgs.antidote}/share/antidote";
			recursive = true;
		};
		".config/zsh/" = {
			source = "${inputs.zsh-config}";
			recursive = true;
		};
		".zshenv".text = "export ZDOTDIR=$HOME/.config/zsh/";
		".config/bat/" = {
			source = "${root}/dotfiles/bat/";
			recursive = true;
		};
	};
}
