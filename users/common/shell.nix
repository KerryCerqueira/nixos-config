{ self, pkgs, flakeInputs, ... }:

{
	home.packages = with pkgs; [
		any-nix-shell
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
			source = "${flakeInputs.zsh-config}/conf.d/";
			recursive = true;
		};
		"fish/conf.d/" = {
			source = "${flakeInputs.fish-config}/conf.d/";
			recursive = true;
		};
		"fish/functions/" = {
			source = "${flakeInputs.fish-config}/functions/";
			recursive = true;
		};
		"bat/" = {
			source = "${self}/dotfiles/bat/";
			recursive = true;
		};
		"kitty/" = {
			source = "${self}/dotfiles/kitty/";
			recursive = true;
		};
		"eza/" = {
			source = "${self}/dotfiles/eza/";
			recursive = true;
		};
	};
	programs = {
		zsh = {
			enable = true;
			dotDir = ".config/zsh";
			antidote = {
				enable = true;
				plugins = let
					zshConfig = flakeInputs.zsh-config;
					splitString = pkgs.lib.strings.splitString;
					pluginsText =  builtins.readFile "${zshConfig}/zsh_plugins.conf";
					zshPlugins = splitString "\n" pluginsText;
				in
					zshPlugins;
			};
			initExtra = # sh
				''
if [[ $(ps -o command= -p "$PPID" | awk '{print $1}') != 'fish' ]]
then
	exec fish -l
else
	any-nix-shell zsh | source /dev/stdin
	source "$ZDOTDIR"/conf.d/conf.zsh
fi
				'';
		};
		fish = {
			enable = true;
			plugins = with pkgs.fishPlugins; [
				{ name = "fish-you-should-use"; src = fish-you-should-use.src; }
				{ name = "forgit"; src = forgit.src; }
				{ name = "fzf-fish"; src = fzf-fish.src; }
				{ name = "pisces"; src = pisces.src; }
			];
			interactiveShellInit = # fish
				''
${pkgs.any-nix-shell}/bin/any-nix-shell fish | source
				'';
		};
		oh-my-posh = {
			enable = true;
			settings = builtins.fromJSON (
				builtins.readFile "${self}/dotfiles/oh-my-posh/config.json"
			);
		};
	};
}
