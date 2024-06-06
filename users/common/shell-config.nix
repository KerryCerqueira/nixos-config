{ ... }:

{
	home.packages = with pkgs; [
		#shell utilities
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
		## Already satisfied by nvim deps, but should be included here which this gets refactored
		## fd
		## ripgrep
		# desktop apps
		keepassxc
		xournalpp
		gimp
		discord
		slack
		thunderbird
		zoom-us
		teams-for-linux
		rnote
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
