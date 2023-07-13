-------------
-- KEYMAPS --
-------------
local opts = { noremap = true, silent = true }
-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap({ "n", "v" }, "<c-j>", "}", opts)
keymap({ "n", "v" }, "<c-k>", "{", opts)
keymap({ "n", "v" }, "<c-h>", "_", opts)
keymap({ "n", "v" }, "<c-l>", "$", opts)
keymap({ "n", "v" }, "<c-;>", "%", opts)

if vim.g.vscode then
	keymap("n", "<leader>o", "<cmd>call VSCodeNotify('workbench.action.quickOpen')<cr>")
	keymap("n", "<leader>w", "<cmd>call VSCodeNotify('workbench.action.files.save')<cr>")
	keymap("n", "<leader>h", "<cmd>call VSCodeNotify('workbench.action.previousEditor')<cr>")
	keymap("n", "<leader>l", "<cmd>call VSCodeNotify('workbench.action.nextEditor')<cr>")
else
	keymap("n", "<leader>w", "<cmd>w<cr>", opts)
	keymap("n", "<leader>h", "<cmd>bprevious<cr>", opts)
	keymap("n", "<leader>l", "<cmd>bnext<cr>", opts)

	keymap('i', 'jj', '<c-c>', opts)
	keymap("n", "<esc><esc>", ":<C-u>set nohlsearch<Return>", opts) -- ESC*2 でハイライトやめる

	keymap('t', '<esc>', '<c-\\><c-n>', opts)
	keymap('t', 'jj', '<c-\\><c-n>', opts)
end


-------------
-- OPTIONS --
-------------
local options = {
	-- ファイル
	fileencoding = "utf-8", -- エンコーディングをUTF-8に設定
	swapfile = false, -- スワップファイルを無効化
	helplang = "ja", -- ヘルプの言語を日本語に設定
	hidden = true,   -- 非表示のバッファーも編集可能にする

	-- カーソルと表示
	cursorline = true, -- カーソルの現在行を強調表示
	cursorcolumn = true, -- カーソルの現在列を強調表示

	-- メニューとコマンド
	wildmenu = true, -- タブ補完やコマンド補完時にワイルドメニューを表示
	cmdheight = 1, -- コマンドラインの表示行数
	laststatus = 2, -- 下部にステータスラインを表示
	showcmd = true, -- コマンドラインに入力されたコマンドを表示

	-- 検索・置換
	hlsearch = true, -- ハイライト検索を有効
	incsearch = true, -- インクリメンタルサーチを有効
	matchtime = 1, -- 入力された文字列がマッチするまでにかかる時間

	-- カラースキーム
	termguicolors = true, -- 24ビットカラーを使用
	background = "dark", -- ダークカラーを使用する

	-- インデント
	shiftwidth = 4, -- シフト幅を4に設定する
	tabstop = 4, -- タブ幅を4に設定する
	expandtab = true, -- タブ文字をスペースに置き換える
	autoindent = true, -- 自動インデントを有効にする
	smartindent = true, -- インデントをスマートに調整する

	-- 表示
	number = true, -- 行番号を表示
	wrap = false, -- テキストの自動折り返しを無効に
	showtabline = 2, -- タブラインを表示(1:常に表示、2:タブが開かれたときに表示)
	visualbell = true, -- ビープ音を表示する代わりに画面をフラッシュ
	showmatch = true, -- 対応する括弧をハイライト表示

	-- インタフェース
	winblend = 20, -- ウィンドウの不透明度
	pumblend = 20, -- ポップアップメニューの不透明度
	signcolumn = "yes", -- サインカラムを表示

	-- undo
	undofile = true,
	undodir = vim.fn.expand('~/.config/nvim/undodir')
}

for option, value in pairs(options) do
	vim.api.nvim_set_option(option, value)
end

-------------
-- AUTOCMD --
-------------
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "plugins.lua" },
	command = "PackerCompile",
})

-- Remove whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = ":%s/\\s\\+$//e",
})

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	command = "set fo-=c fo-=r fo-=o",
})

-- Restore cursor location when file is opened
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


require("plugins")
