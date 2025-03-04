{ self, pkgs, flakeInputs, ... }:
let
	root = self;
in {
	home.packages = with pkgs; [
		git
		zsh
		kitty
		antidote
		btop
		fzf
		atuin
		eza
		moar
		tldr
		dust
		fd
		ripgrep
		bat
		sshfs
		bat-extras.batman
		bat-extras.batgrep
		bat-extras.batdiff
		timg
		yazi
	];
	home.file = {
		".local/share/zsh/antidote/" = {
			source = "${pkgs.antidote}/share/antidote";
			recursive = true;
		};
		".config/zsh/" = {
			source = "${flakeInputs.zsh-config}";
			recursive = true;
		};
		".zshenv".text = "export ZDOTDIR=$HOME/.config/zsh/";
		".config/bat/" = {
			source = "${root}/dotfiles/bat/";
			recursive = true;
		};
		".config/kitty/" = {
			source = "${root}/dotfiles/kitty/";
			recursive = true;
		};
		".config/eza/" = {
			source = "${root}/dotfiles/eza/";
			recursive = true;
		};
	};
}
