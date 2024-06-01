{ pkgs, configRoot, nvim-config, ... }:

{
	home.username = "kerry";
	home.homeDirectory = "/home/kerry";
	home.stateVersion = "23.11";
	programs = {
		home-manager.enable = true;
		zathura.enable = true;
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
		# secrets tools
		# TODO: Probably don't need these always available
		sops
		libsecret
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
		micromamba
		#rust
		cargo
		rustc
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
	services = {
		easyeffects = {
			enable = true;
			preset = "AdvancedAutoGain";
		};
	};
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
		".config/easyeffects/" = {
			source = "${configRoot}/dotfiles/easyeffects/";
			recursive = true;
		};
		".config/nvim/" = {
			source = "${nvim-config}";
			recursive = true;
		};
	};
}
