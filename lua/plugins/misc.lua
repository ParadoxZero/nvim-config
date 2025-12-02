return {
  { "ojroques/vim-oscyank", branch = "main",
    config = function()
      local wk = require("which-key")
      wk.add({
       {'<leader>c', '<Plug>OSCYankOperator', desc = "Copy to system Clipboard"},
        -- vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
       {'<leader>c', '<Plug>OSCYankVisual', desc = "Copy to system Clipboard", mode = 'v'}
      })
    end
  }
}
