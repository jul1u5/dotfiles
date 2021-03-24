{ pkgs, ... }:

{
  services.xserver = {
    libinput = {
      enable = true;

      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
        accelProfile = "flat";
      };
    };

    # config = ''
    #   Section "InputClass"
    #     Identifier "mouse accel"
    #     Driver "libinput"
    #     MatchIsPointer "yes"
    #     Option "AccelProfile" "flat"
    #     Option "AccelSpeed" "0"
    #   EndSection
    # '';
  };
}
