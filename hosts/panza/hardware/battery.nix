{ ... }:

{
	powerManagement.enable = true;
	services = {
		thermald.enable = true;
		upower.enable = true;
		auto-cpufreq = {
			enable = true;
			settings = {
				battery = {
					governor = "powersave";
					turbo = "never";
				};
				charger = {
					governor = "performance";
					turbo = "auto";
				};
			};
		};
	};
}
