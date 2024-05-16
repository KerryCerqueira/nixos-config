{ pkgs, configRoot, ... }:

{
	home.username = "erika";
	home.homeDirectory = "/home/erika";
	home.stateVersion = "23.11";
	programs = {
		home-manager.enable = true;
		zathura.enable = true;
		chromium.enable = true;
		firefox.enable = true;
		vscode = {
			enable = true;
			package = pkgs.vscode.fhsWithPackages (ps: with ps; [
					jdk
			]);
		};
	};
	home.packages = with pkgs; [
		zsh
		#shell utilities
		ranger
		btop
		# nvim dependencies
		gnumake
		gcc
		antidote
		fd
		ripgrep
		git
		neovide
		xclip
		jdk
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
		# TODO: create shell.nix to run FHS for this
		micromamba
		# desktop apps
		xournalpp
		gimp
		discord
		slack
		libreoffice
		thunderbird
		zoom-us
	];
	home.file = {
		".config/zsh/zshrc".source = "${configRoot}/dotfiles/zsh/zshrc";
		".config/zsh/.zshrc".text  = ''
			source ${pkgs.antidote}/share/antidote/antidote.zsh
			source ''${HOME}/.config/zsh/zshrc
		'';
		".config/zsh/p10k.zsh".source = "${configRoot}/dotfiles/zsh/p10k.zsh";
		".config/zsh/zsh_plugins.conf".source
			= "${configRoot}/dotfiles/zsh/zsh_plugins.conf";
	};
}
