--[[
    SPDX-FileCopyrightText: 2024 Name <lasagna@garfunkle.space>
    SPDX-License-Identifier: MPL-2.0
  ]]

---- Setup LSP's
local lsp = require('lspconfig');
local schemastore = require('schemastore');

local servers = {
  bashls = {},
  cssls = {},
  denols = {
    root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc"),
    single_file_support = false,
  },
  emmet_language_server = {
    filetypes = {
      "css",
      "eruby",
      "html",
      "vtml",
      "htmltera",
      "svelte",
      "vue",
      "javascript",
      "less",
      "sass",
      "scss",
    },
  },
  helm_ls = {},
  jqls = {},
  jsonls = {
    settings = {
      json = {
        schemas = schemastore.json.schemas(),
        validate = { enable = true },
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        completion = true,
        schemas = schemastore.yaml.schemas(),
        suggest = { parentSkeletonSelectedFirst = true },
        validate = true,
      },
    },
  },
  lua_ls = {},
  html = {},
  ltex = {
    on_attach = function()
      require("ltex_extra").setup({
        load_langs = { "en-GB", "fr" },
        path = vim.fn.stdpath("data") .. "/dictionary",
      })
    end,
    settings = {
      ltex = {
        language = "en-GB",
        additionalRules = {
          enablePickyRules = true,
          motherTongue = "en-GB",
        },
      },
    },
  },
  nil_ls = {
    settings = {
      ['nil'] = {
        formatting = {
          command = { "nixfmt" },
        },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = true,
        }
      }
    }
  }
}

--- Apply common capabilities
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help),
}

local capabilities = require('cmp_nvim_lsp').default_capabilities();

local common = {
  capabilities = capabilities,
  handlers = handlers,
}

for server, config in pairs(servers) do
  if config == {} then
    lsp[server].setup(common)
  else
    lsp[server].setup(vim.tbl_extend("force", common, config))
  end
end

--- Autocommand hooks
-- LSP Keybinds
vim.api.nvim_create_autocmd('LspAttach', {
  pattern = '*',
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  end
})

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    vim.lsp.buf.format({ async = true })
  end
})
