let
  monitors = {
    surface-pro-8 = {
      name = "eDP-1";
      width = 2880;
      height = 1920;
      refreshRate = 60;
      x = 0;
      y = 0;
      scale = 2;
      enabled = true;
    };
    dell-xps-17 = {
      name = "eDP-1";
      width = 3840;
      height = 2400;
      refreshRate = 60;
      x = 0;
      y = 0;
      scale = 2;
      enabled = true;
    };
    view-sonic-32 = {
      name = "DP-2";
      width = 2560;
      height = 1440;
      refreshRate = 60;
      x = 1440;
      y = 0;
      scale = 1.5;
      enabled = true;
    };
  };
in
monitors
