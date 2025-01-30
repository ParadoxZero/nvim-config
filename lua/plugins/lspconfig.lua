return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  lazy = true,
  config = function() 
    require'lspconfig'.clangd.setup{}  
  end
}
