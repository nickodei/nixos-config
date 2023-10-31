{ _, ... }: {
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
      "<tab>" = "cmp.mapping.select_next_item()";
      "<s-tab>" = "cmp.mapping.select_prev_item()";
      "<c-n>" = "cmp.mapping.select_next_item()";
      "<c-p>" = "cmp.mapping.select_prev_item()";
    };
  };
}
