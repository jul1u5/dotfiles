local lsp_format = require("lsp-format")
local wk = require("which-key")

local disable_format_cap = {
  "dartls",
  "sumneko_lua",
  "rust_analyzer",
  "rnix",
  "gopls",
  "elixirls",
}

local on_attach = function(client, bufnr)
  for _, v in pairs(disable_format_cap) do
    if v == client.name then
      client.server_capabilities.document_formatting = false
      break
    end
  end

  lsp_format.on_attach(client)

  local keymaps = {
    K = { vim.lsp.buf.hover, "Hover docs" },
    g = {
      name = "LSP",
      D = { vim.lsp.buf.declaration, "Go to declaration" },
      -- d = { vim.lsp.buf.definition, "Go to definition" }, -- This is declared in Treesitter instead.
      i = { vim.lsp.buf.implementation, "Go to implementation" },

      r = { vim.lsp.buf.rename, "Rename" },

      o = { vim.diagnostic.open_float, "Show diagnostics for line" },
      x = { "<cmd>CodeActionMenu<CR>", "Show code actions" },
    },

    ["]e"] = { vim.diagnostic.goto_next, "Next diagnostic" },
    ["[e"] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
  }

  wk.register(keymaps, {
    mode = "n",
    buffer = bufnr,
    silent = true,
    noremap = true,
  })
end

return on_attach
