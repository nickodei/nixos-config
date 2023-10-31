{ _, ... }: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      #folding = true;
      indent = true;
    };
    ts-context-commentstring.enable = true;
    nvim-autopairs = {
      enable = true;
      checkTs = true;
      disableInMacro = true;
      disableInVisualblock = true;
    };
    ts-autotag.enable = true;
  };
}
