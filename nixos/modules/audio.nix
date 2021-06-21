{ pkgs, ... }:

{
  hardware.pulseaudio = {
    enable = false;

    daemon.config = {
      realtime-scheduling = "yes";
    };

    extraConfig = ''
      load-module module-echo-cancel aec_method=webrtc source_master=alsa_input.pci-0000_00_1f.3.analog-stereo source_name=echo_cancelled
      set-default-source echo_cancelled
    '';
  };

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

  environment.systemPackages = with pkgs; [
    pulseaudioFull
    jack2Full

    pamixer
    pulsemixer

    pavucontrol
    pulseeffects-pw

    cadence
    playerctl
  ];
}
