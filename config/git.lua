---- Fugitive
--- Maps for fugitive
-- General
vim.keymap.set('n', '<leader>gv', '<Cmd>Git<Cr>', { desc = 'Open Git view' });
vim.keymap.set('n', '<leader>gd', '<Cmd>lua vim.cmd("Git diff " .. vim.fn.input("Branch to diff against: "))<CR>',
  { desc = 'Open Git diff' });
vim.keymap.set('n', '<leader>gb', '<Cmd>lua vim.cmd("Git checkout -b " .. vim.fn.input("Branch name: "))<CR>',
  { desc = 'Open Git branch' });

-- Pull / Push
vim.keymap.set('n', '<leader>gy', '<Cmd>Git pull<Cr>', { desc = 'Git pull' });
vim.keymap.set('n', '<leader>gp', '<Cmd>Git push<Cr>', { desc = 'Git push' });

-- Commiting
vim.keymap.set('n', '<leader>gcc', '<Cmd>Git commit<Cr>', { desc = 'Git commit' });
vim.keymap.set('n', '<leader>gca', '<Cmd>Git commit --amend<Cr>', { desc = 'Git commit amend' });




---- Git signs
require('gitsigns').setup()
