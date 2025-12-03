return {
  "camspiers/snap",
  config = function ()
    -- Basic example config
    local snap = require"snap"
    local wk = require("which-key")
    wk.add({
      {"<Leader>s", group = "Search", desc = "Search Codebase"},
      {"<Leader>sf", snap.config.file {producer = "ripgrep.file"}, desc = "Search workspace files"},
      {"<Leader>so", snap.config.file {producer = "vim.buffer"}, desc = "Search open buffers"},
      {"<Leader>sO", snap.config.file {producer = "vim.oldfile"}, desc="Search old files"},
      {"<Leader>svim", snap.config.vimgrep {}, desc = "Search VIM Configs"},
--     {"<Leader>s/", snap.config.file {producer = "vim.currentbuffer"}, desc = "Search current file"}
    })
  end,
  enabled = false
}
