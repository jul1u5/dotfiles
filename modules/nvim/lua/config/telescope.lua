local actions = require("telescope.actions")
require("telescope").setup({
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    live_grep = {
      mappings = {
        i = { ["<c-f>"] = actions.to_fuzzy_refine },
      },
    },
    buffers = {
      theme = "ivy",
    },
    help_tags = {
      theme = "ivy",
    },
    keymaps = {
      theme = "ivy",
    },
    lsp_references = {
      theme = "ivy",
    },
    git_commits = {
      theme = "ivy",
    },
    git_bcommits = {
      theme = "ivy",
    },
    git_branches = {
      theme = "ivy",
    },
  },
})

require("which-key").register({
  s = {
    s = {
      "<cmd>Telescope live_grep<CR>",
      "Find with ripgrep",
    },
    r = { "<cmd>Telescope lsp_references<CR>", "Find LSP references" },
  },
  f = {
    name = "Files",
    f = { "<cmd>Telescope find_files<CR>", "Find files" },
  },
  b = {
    b = { "<cmd>Telescope buffers<CR>", "Find buffers" },
  },
  g = {
    name = "Git",
    c = { "<cmd>Telescope git_commits<CR>", "Find Git commits" },
    b = {
      name = "Find b...",
      r = { "<cmd>Telescope git_branches<CR>", "Find Git branches" },
      c = { "<cmd>Telescope git_bcommits<CR>", "Find Git buffer commits" },
    },
  },
  h = {
    name = "Help",
    h = { "<cmd>Telescope help_tags<CR>", "Find help tags" },
    k = { "<cmd>Telescope keymaps<CR>", "Find keymaps" },
  },
}, {
  mode = "n",
  prefix = "<Leader>",
  silent = true,
  noremap = true,
})
