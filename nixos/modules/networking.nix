{...}: {
  systemd.services.NetworkManager-wait-online.enable = false;
  networking = {
    networkmanager.enable = true;
    dhcpcd.wait = "background";
  };
}
