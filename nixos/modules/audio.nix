{ pkgs, ... }:

{
  hardware = {
    pulseaudio.enable = false;
  };

  security = {
    rtkit.enable = true;
  };

  services.pipewire = {
    enable = true;

    pulse.enable = true;
    jack.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    #config.pipewire = {
    #  "context.properties" = {
    #    # Fixes stuttering while playing audio in Spotify and Firefox at the same time.
    #    #
    #    # When Firefox plays something via PipeWire the quant (buffer size) of the
    #    # output decreases to 2048 (this is lower than the default value 8096 which Spotify uses).
    #    # The stuttering occurs when Firefox closes the stream which increases the buffer size.
    #    # This is very noticeable with YouTube previews.
    #    "default.clock.max-quantum" = 2048;
    #  };
    #};
  };

  user.packages = with pkgs; [
    pulseaudioFull
    jack2Full

    pamixer
    pulsemixer

    cadence
    cava
    carla

    helvum
    pavucontrol
    playerctl
  ];

  home._ = {
    services = {
      easyeffects.enable = true;
    };
  };
}
