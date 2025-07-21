--[[
    SPDX-FileCopyrightText: 2024 Name <lasagna@garfunkle.space>
    SPDX-License-Identifier: EUPL-1.2
  ]]

---Setup telescope
local tele = require('telescope');

-- tele.setup{
--   defaults = {
--     -- Default configuration for telescope goes here:
--     -- config_key = value,
--     mappings = {
--       i = {
--         -- map actions.which_key to <C-h> (default: <C-/>)
--         -- actions.which_key shows the mappings for your picker,
--         -- e.g. git_{create, delete, ...}_branch for the git_branches picker
--         ["<C-h>"] = "which_key"
--       }
--     }
--   },
--   pickers = {
--     -- Default configuration for builtin pickers goes here:
--     -- picker_name = {
--     --   picker_config_key = value,
--     --   ...
--     -- }
--     -- Now the picker_config_key will be applied every time you call this
--     -- builtin picker
--   },
--   extensions = {
--     -- Your extension configuration goes here:
--     -- extension_name = {
--     --   extension_config_key = value,
--     -- }
--     -- please take a look at the readme of the extension you want to configure
--   }
-- }

-- Enable telescope filebuffer
tele.load_extension('file_browser');

-- Enable UI Select
tele.load_extension('ui-select');

--- Keybinds
local builtin = require('telescope.builtin');

-- Open file_browser with the path of the current buffer
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
  { desc = 'File browser', })

-- Telescope specific bindings
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = 'Telescope find commit' })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope switch branch' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
