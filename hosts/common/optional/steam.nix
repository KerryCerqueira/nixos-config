{ ... }:

{
	programs.steam.enable = true;
	environment.variables = {
		STEAM_FORCE_DESKTOPUI_SCALING = "2";
	};
}
