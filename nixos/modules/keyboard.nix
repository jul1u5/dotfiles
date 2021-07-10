{
  services.xserver = {
    layout = "us,lt";
    xkbOptions = "ctrl:swapcaps,grp:rctrl_rshift_toggle,compose:ralt";
  };

  console.useXkbConfig = true;
}
