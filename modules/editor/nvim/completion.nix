{ _, ... }: {
  #programs.nixvim.plugins.coq-nvim.enable = true;
  #programs.nixvim.plugins.coq-nvim.installArtifacts = true;
  programs.nixvim.plugins.nvim-cmp = {
    enable = true;
    completion = {
      autocomplete = [ "TextChanged" ];
      keywordLength = 1;
    };
    sources = [
      { name = "nvim_lsp"; }
      { name = "nvim_lua"; }
      { name = "path"; }
      { name = "buffer"; }
    ];
    formatting = {
      fields = [ "abbr" "kind" "menu" ];
      format =
        # lua
        ''
          function(_, item)
            local icons = {
              Namespace = "󰌗",
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰆧",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈚",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "󰊄",
              Table = "",
              Object = "󰅩",
              Tag = "",
              Array = "[]",
              Boolean = "",
              Number = "",
              Null = "󰟢",
              String = "󰉿",
              Calendar = "",
              Watch = "󰥔",
              Package = "",
              Copilot = "",
              Codeium = "",
              TabNine = "",
            }

            local icon = icons[item.kind] or ""
            item.kind = string.format("%s %s", icon, item.kind or "")
            return item
          end
        '';
    };
    mapping = {
      "<C-k>" = "cmp.mapping.select_prev_item()"; # previous suggestion
      "<C-j>" = "cmp.mapping.select_next_item()"; #next suggestion
      "<C-b>" = "cmp.mapping.scroll_docs(-4)";
      "<C-f>" = "cmp.mapping.scroll_docs(4)";
      "<C-Space>" = "cmp.mapping.complete()"; # show completion suggestions
      "<C-e>" = "cmp.mapping.abort()"; # close completion window
      "<CR>" = "cmp.mapping.confirm({ select = false })";
    };
  };
}
