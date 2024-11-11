---- Editor
--- General
-- Disable wrapping
vim.opt.wrap = false;

-- Set leader key
vim.g.mapleader = ' ';

-- Display line numbers
vim.opt.number = true;
vim.opt.relativenumber = true;

vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  callback = function()
    vim.opt.relativenumber = false -- Set to absolute line numbers in Insert mode
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    vim.opt.relativenumber = true -- Set to relative line numbers in Normal mode
  end,
})

-- Enables smartcase for searching
vim.opt.smartcase = true;

-- Enable nerdfont
vim.g.have_nerd_font = true;

--- Tab options
-- Sets tabs to be 2 spaces wide
vim.opt.tabstop = 2;
vim.opt.shiftwidth = 2;

-- Converts tabs to spaces
vim.opt.expandtab = true;


--- Themeing
vim.opt.termguicolors = true;
vim.cmd.colorscheme('catppuccin-mocha');




--- Keybinds: vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
-- Launch terminal on <leader>t at the bottom
vim.keymap.set('n', '<leader>t', '<cmd>bo term<cr>', { desc = 'Launch terminal' })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd("resize 10")
  end,
})



---- Importing modules
--- Config
-- NOTE: Normally you would need to import these modules BUT because we're doing a hacky fix
-- by adding all these files as plugins in our flake, we no longer need too.
--[[
require('config.treesitter');
require('config.telescope');
require('config.lsp');
require('config.comp');
]] --

--- Plugins
require('which-key');
