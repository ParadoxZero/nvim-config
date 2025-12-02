return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  enabled = false,
  lazy = false,
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = false,
      buffers = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --              -- the current file is changed while the tree is open.
          leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      },
      window = {
        position = "current",
        width = "fit_content",
      },
      filesystem = {
        follow_current_file = {
        enabled = true,  -- automatically focus current file
        leave_dirs_open = true,
      },
  },
    })
    vim.keymap.set("n", "<leader>e", ":Neotree reveal<CR>", { desc = "Open Neo-tree" })
  end,
}
