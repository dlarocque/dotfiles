local null_ls = require("null-ls")

null_ls.setup({
    debug = false,
    sources = {
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.prettier.with({ filetypes = {"vimwiki"} }),
    },
})
