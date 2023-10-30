{
  plugins.none-ls = {
    enable = true;
    sources = {
      diagnostics = {
        shellcheck.enable = true;
        statix.enable = true;
      };
      formatting = {
        #fantomas.enable = true;
        nixfmt.enable = true;
        nixpkgs_fmt.enable = true;
      };
    };
  };
}
