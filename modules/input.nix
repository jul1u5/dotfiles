{
  services.xserver = {
    libinput = {
      enable = true;

      mouse = {
        accelProfile = "flat";
      };

      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
        accelProfile = "flat";
      };
    };
  };
}
