------------- KEYMAPS ---------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--
local opts = { noremap = true, silent = true }
local keyset = vim.keymap.set
keyset({ "n", "v" }, "J", "10j", opts)
keyset({ "n", "v" }, "K", "10k", opts)
keyset({ "n", "v" }, "H", "_", opts)
keyset({ "n", "v" }, "L", "$", opts)
keyset({ "n", "v" }, ";", "zz", opts)
keyset({ "n", "v" }, "<Space>y", "\"+y", opts)
keyset({ "n", "v" }, "<Space>p", "\"+p", opts)
keyset({ "n", "v" }, "<leader>h", "<cmd>bprevious<cr>", opts)
keyset({ "n", "v" }, "<leader>l", "<cmd>bnext<cr>", opts)
keyset({ "n", "v" }, "<leader>q", ":<C-u>q!<Return>", opts)
keyset({ "n", "v" }, "<c-j>", ":", opts)
keyset('i', 'jj', '<Esc>', opts)
keyset("i", ",", ",<Space>", opts)
keyset("n", "<leader>w", "<cmd>w<cr>", opts)
keyset("n", "<esc><esc>", ":<c-u>set nohlsearch<cr>", opts)
keyset('t', 'jj', '<c-\\><c-n>', opts)

-------------
-- OPTIONS --
-------------
local options = {
  -- ファイル
  fileencoding = "utf-8", -- エンコーディングをUTF-8に設定
  swapfile = false,       -- スワップファイルを無効化
  helplang = "ja",        -- ヘルプの言語を日本語に設定
  hidden = true,          -- 非表示のバッファーも編集可能にする

  -- カーソルと表示
  cursorline = true,   -- カーソルの現在行を強調表示
  -- cursorcolumn = true, -- カーソルの現在列を強調表示

  -- メニューとコマンド
  wildmenu = true, -- タブ補完やコマンド補完時にワイルドメニューを表示
  cmdheight = 1,   -- コマンドラインの表示行数
  laststatus = 2,  -- 下部にステータスラインを表示
  showcmd = true,  -- コマンドラインに入力されたコマンドを表示

  -- 検索・置換
  hlsearch = true,  -- ハイライト検索を有効
  incsearch = true, -- インクリメンタルサーチを有効
  matchtime = 1,    -- 入力された文字列がマッチするまでにかかる時間

  -- カラースキーム
  termguicolors = true, -- 24ビットカラーを使用
  background = "dark",  -- ダークカラーを使用する

  -- インデント
  shiftwidth = 2,     -- シフト幅を4に設定する
  tabstop = 2,        -- タブ幅を4に設定する
  expandtab = true,   -- タブ文字をスペースに置き換える
  autoindent = true,  -- 自動インデントを有効にする
  smartindent = true, -- インデントをスマートに調整する

  -- 表示
  number = true,     -- 行番号を表示
  wrap = false,      -- テキストの自動折り返しを無効に
  showtabline = 2,   -- タブラインを表示(1:常に表示、2:タブが開かれたときに表示)
  visualbell = true, -- ビープ音を表示する代わりに画面をフラッシュ
  showmatch = true,  -- 対応する括弧をハイライト表示

  -- インタフェース
  winblend = 0,      -- ウィンドウの不透明度
  pumblend = 0,      -- ポップアップメニューの不透明度
  signcolumn = "yes", -- サインカラムを表示

  -- undo
  undofile = true,
  undodir = vim.fn.expand('~/.config/nvim/undodir')
}

for option, value in pairs(options) do
  vim.opt[option] = value
end

-------------
-- AUTOCMD --
-------------
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
-- vim.cmd([[
-- augroup packer_user_config
-- autocmd!
-- autocmd BufWritePost plugins.lua source <afile> | PackerSync | PackerCompile
-- augroup end
-- ]])

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  command = "PackerCompile",
})

-- Neovim クリップボード設定（フルパス指定）
local is_wsl = true
if is_wsl then
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = "/home/ykobari/bin/win32yank.exe -i --crlf",
      ["*"] = "/home/ykobari/bin/win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "/home/ykobari/bin/win32yank.exe -o --lf",
      ["*"] = "/home/ykobari/bin/win32yank.exe -o --lf",
    },
    cache_enabled = 1,
  }
end

require("plugins")
