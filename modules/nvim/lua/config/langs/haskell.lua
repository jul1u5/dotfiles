require("haskell-tools").setup({
  hls = {
    on_attach = require("config.lsp.on_attach"),
    settings = {
      haskell = {
        -- formattingProvider = "none",
        checkProject = true,
      },
    },
  },
})
