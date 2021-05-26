{ pkgs, ... }:

{
  sound.enable = true;

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
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pulseaudioLight
    pamixer
    pulsemixer

    pavucontrol
    pulseeffects-pw

    spotify
    playerctl
  ];
}
