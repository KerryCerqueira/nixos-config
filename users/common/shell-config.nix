{ pkgs, configRoot, ... }:

{
	programs.zsh.enable = true;
	home.sessionVariables = {
		ZDOTDIR = "$HOME/.config/zsh";
	};
	home.packages = with pkgs; [
		kitty
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
		".config/zsh/zshrc".source =
			"${configRoot}/dotfiles/zsh/zshrc";
		".config/zsh/.zshrc".text  = ''
			source ${pkgs.antidote}/share/antidote/antidote.zsh
			source ''${HOME}/.config/zsh/zshrc
		'';
		".config/zsh/p10k.zsh".source =
			"${configRoot}/dotfiles/zsh/p10k.zsh";
		".config/zsh/zsh_plugins.conf".source =
			"${configRoot}/dotfiles/zsh/zsh_plugins.conf";
	};
}
