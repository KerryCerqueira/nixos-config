{ ... }:

{
	#boot.kernelParams = ["i915.enable_guc=2"];
	hardware.sensor.iio.enable = true;
	services.fprintd.enable = true;
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};
}
