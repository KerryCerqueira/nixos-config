{ self, pkgs, flakeInputs, ... }:
let
	root = self;
	zshDotfiles = flakeInputs.zsh-config;
	zshPluginsText = builtins.readFile "${zshDotfiles}/zsh_plugins.conf";
	zshPlugins = pkgs.lib.strings.splitString "\n" zshPluginsText;
in {
	home.packages = with pkgs; [
		git
		btop
		fzf
		eza
		moar
		tldr
		dust
		fd
		ripgrep
		bat
		bat-extras.batman
		bat-extras.batgrep
		bat-extras.batdiff
		timg
		yazi
	];
	xdg.configFile = {
		"zsh/conf.d/" = {
			source = "${zshDotfiles}/conf.d/";
			recursive = true;
		};
		"bat/" = {
			source = "${root}/dotfiles/bat/";
			recursive = true;
		};
		"kitty/" = {
			source = "${root}/dotfiles/kitty/";
			recursive = true;
		};
		"eza/" = {
			source = "${root}/dotfiles/eza/";
			recursive = true;
		};
	};
	programs = {
		zsh = {
			enable = true;
			dotDir = ".config/zsh";
			initExtra = # sh
				''
 if [[ $(ps -o command= -p "$PPID" | awk '{print $1}') != 'fish' ]]
 then
	 exec fish -l
 else
	 source "$ZDOTDIR"/conf.d/conf.zsh
 fi
				'';
			antidote = {
				enable = true;
				plugins = zshPlugins;
			};
		};
		oh-my-posh = {
			enable = true;
			settings = builtins.fromJSON (
				builtins.readFile "${root}/dotfiles/oh-my-posh/config.json"
			);
		};
	};
}
