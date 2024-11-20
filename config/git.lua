--[[
    SPDX-FileCopyrightText: 2024 Name <lasagna@garfunkle.space>
    SPDX-License-Identifier: MPL-2.0
  ]]

---- Fugitive
--- Maps for fugitive
function set_git_keymaps()
  -- General
  vim.keymap.set('n', '<leader>gv', '<Cmd>Git<Cr>', { desc = 'Open Git view' });
  vim.keymap.set('n', '<leader>gd',
    '<Cmd>lua vim.cmd("Git diff " .. vim.fn.input("Branch to diff against (blank for working dir): "))<Cr>',
    { desc = 'Open Git diff' });

  -- Pull / Push
  vim.keymap.set('n', '<leader>gy', '<Cmd>Git pull<Cr>', { desc = 'Git pull' });
  vim.keymap.set('n', '<leader>gp', '<Cmd>Git push<Cr>', { desc = 'Git push' });

  -- Commiting
  vim.keymap.set('n', '<leader>gcc', '<Cmd>Git commit<Cr>', { desc = 'Git commit' });
  vim.keymap.set('n', '<leader>gca', '<Cmd>Git commit --amend<Cr>', { desc = 'Git commit amend' });
end

-- Run this function after Vim is fully loaded
-- We need to do this as fugitive is a VimScript plugin and binding against it whilst it isn't ready leads to errors
vim.cmd([[
  augroup GitKeymaps
    autocmd VimEnter * lua set_git_keymaps()
  augroup END
]])


---- Git signs
require('gitsigns').setup()
