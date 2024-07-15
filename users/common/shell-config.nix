{ pkgs, inputs, ... }:

{
	home.sessionVariables = {
		ZDOTDIR = "$HOME/.config/zsh";
	};
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
		bat
		dust
		powertop
		xplr
		fd
		ripgrep
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
	};
}
