--[[
    SPDX-FileCopyrightText: 2024 Name <lasagna@garfunkle.space>
    SPDX-License-Identifier: EUPL-1.2
  ]]

-- Launch treesitter instead of regex
vim.treesitter.start();

-- Fold with Treesitter
vim.opt.foldenable = false;
vim.wo.foldmethod = 'expr';
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()';
