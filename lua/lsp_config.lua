
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright",
        "lua_ls",
        "html",
    },
})


require("lspconfig").pyright.setup({})
-- require("lspconfig").lua_ls.setup({})
require("lspconfig").html.setup({})
require('lspconfig').lua_ls.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim'}
            }
        }
    }
}
--
-- 1.formatter, 2.linter
-- local null_ls = require("null-ls")
require("null-ls").setup({
    sources = {
        -- python
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.diagnostics.flake8,
        require("null-ls").builtins.formatting.isort,

        -- lua
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.diagnostics.luacheck,

        -- html
        -- require("null-ls").builtins.formatting.htmlhint,
        require("null-ls").builtins.formatting.prettierd,
        -- require("null-ls").builtins.diagnostics.prettierd,
    }
})

