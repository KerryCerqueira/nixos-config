{ pkgs, ...}:

{
	programs = {
		programs.zsh.enable = true;
		programs.neovim = {
			enable = true;
			defaultEditor = true;
		};
	};
	users.defaultUserShell = pkgs.zsh;
}
