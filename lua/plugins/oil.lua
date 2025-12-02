return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  config = function()
    require("oil").setup({
      float = {
        padding = 5,
        max_width = 0.8,
        max_height = 0.6,
        border = "rounded",
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = function(winid) return "Oil" end,
      },
    })
    local function open_oil_here()
      require("oil").open_float()
    end
    local wk = require("which-key")
    wk.add({
      {"<Leader>e", open_oil_here, desc = "Open current folder"},
    })
  end
}
