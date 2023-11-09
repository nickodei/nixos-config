{
  formatting.command = "alejandra";
  options = {
    enable = true;
    target = {
      args = [ ];
      installable = ".#nixosConfigurations.surface.options";
    };
  };
}
