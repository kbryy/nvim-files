require("plugins")
require("keymaps")
require("options")
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
    -- light_style = "day",
    transparent = true, -- 背景を半透明
    -- ide_inactive_statusline = t,
})
require("notify").setup({
    background_colour = '#000000'
})

vim.g['clever_f_across_no_line'] = 1
vim.cmd([[colorscheme tokyonight-night]])
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "plugins.lua" },
    command = "PackerCompile",
})

vim.api.nvim_set_var('maplocalleader', ' ')
vim.g.vimtex_compiler_latexmk = { continuous = 0 }
vim.g.vimtex_syntax_enabled = 0

vim.cmd('au FileType * setlocal fo-=c fo-=r fo-=o') -- 改行時の自動コメントアウト無効
