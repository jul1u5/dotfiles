{
  home._ = {
    wayland.windowManager.sway = {
      config = {
        input = {
          "type:touch".map_to_output = "eDP-1";
          "type:tablet_tool".map_to_output = "eDP-1";
        };

        output =
          let
            externalQHD = {
              res = { w = 2560; h = 1440; };
              pos = { x = 0; y = 0; };
            };

            externalFHD = {
              res = { w = 1920; h = 1080; };
              pos = { x = 0; y = 0; };
            };

            external = externalFHD;

            internal = rec {
              res = { w = 1920; h = 1080; };
              pos = {
                x = (external.res.w - res.w) / 2;
                y = external.res.h;
              };
            };

            toConfig = { res, pos }: {
              resolution = with res; "${toString w}x${toString h}";
              position = with pos; "${toString x},${toString y}";
            };
          in
          {
            "eDP-1" = toConfig internal;
            "Goldstar Company Ltd LG QHD 005KMZRY1189" = toConfig externalQHD;
            "Goldstar Company Ltd 23MP75 " = toConfig externalFHD;
          };
      };
    };
  };
}
