require("plugins")

require("keymaps")

require("options")

-- require("autocmds")
-- require("nvim_cmp_config")
-- require("lsp_config")

require("lualine").setup()

require("tabline").setup()

require("mini.indentscope").setup({
    symbol = "▏",
})

require("nvim-treesitter.configs").setup({
    -- auto_install = true, -- docker-myenvでエラーになる
    highlight = { enable = true, },
})

require("tokyonight").setup({
    light_style = "day",
    transparent = true, -- 背景を半透明
    -- ide_inactive_statusline = t,
})

require("notify").setup({
    background_colour = '#000000'
})

-- require("noice").setup({
--     lsp = {
--         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--         override = {
--             ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--             ["vim.lsp.util.stylize_markdown"] = true,
--             ["cmp.entry.get_documentation"] = true,
--         },
--     },
--     -- you can enable a preset for easier configuration
--     presets = {
--         bottom_search = false, -- use a classic bottom cmdline for search
--         command_palette = false, -- position the cmdline and popupmenu together
--         long_message_to_split = true, -- long messages will be sent to a split
--         inc_rename = false, -- enables an input dialog for inc-rename.nvim
--         lsp_doc_border = false, -- add a border to hover docs and signature help
--     },
-- })

vim.g['clever_f_across_no_line'] = 1
vim.cmd([[colorscheme tokyonight-night]])
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "plugins.lua" },
    command = "PackerCompile",
})

vim.api.nvim_set_var('maplocalleader', ' ')
vim.g.vimtex_compiler_latexmk = { continuous = 0 }
vim.g.vimtex_syntax_enabled = 0
