{ pkgs, ... }:

{
  services.xserver = {
    libinput = {
      enable = true;
      naturalScrolling = true;
      disableWhileTyping = true;
      accelProfile = "flat";
    };
    config = ''
      Section "InputClass"
        Identifier "mouse accel"
        Driver "libinput"
        MatchIsPointer "yes"
        Option "AccelProfile" "flat"
        Option "AccelSpeed" "0"
      EndSection
    '';

    multitouch = {
      enable = true;
      invertScroll = true;
      ignorePalm = true;
    };

    wacom.enable = true;
    modules = [ pkgs.xf86_input_wacom ];
  };
}
