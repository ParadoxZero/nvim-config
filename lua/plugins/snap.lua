return {
  "camspiers/snap",
  config = function ()
    -- Basic example config
    local snap = require"snap"
    current_file_search = function()
    snap.run({
      producer = snap.get('consumer.fzf')(snap.get('producer.vim.currentbuffer')),
      select = snap.get('select.currentbuffer').select
    })
    end
    local wk = require("which-key")
    wk.add({
      {"<Leader>s", group = "Search", desc = "Search Codebase"},
      {"<Leader>sf", snap.config.file {producer = "ripgrep.file"}, desc = "Search workspace files"},
      {"<Leader><Leader>", snap.config.file {producer = "vim.buffer"}, desc = "Search open buffers"},
      {"<Leader>so", snap.config.file {producer = "vim.oldfile"}, desc="Search old files"},
      {"<Leader>svim", snap.config.vimgrep {}, desc = "Search VIM Configs"},
      {"<Leader>s/", current_file_search, desc = "Search current file"}
    })
  end
}
