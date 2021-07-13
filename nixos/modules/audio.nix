{ pkgs, ... }:

{
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;
    jack.enable = true;
  };

  user.packages = with pkgs; [
    pulseaudioFull
    jack2Full

    pamixer
    pulsemixer

    cadence
    cava
    pavucontrol
    playerctl
    pulseeffects-pw
  ];
}
