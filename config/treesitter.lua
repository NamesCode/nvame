-- Setup nvim-treesitter
require('nvim-treesitter.configs').setup {
  -- Enable Treesitter highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  -- Something
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

-- Fold with Treesitter
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
