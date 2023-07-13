-------------
-- KEYMAPS --
-------------
local opts = { noremap = true, silent = true }
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
    keymap("n", "<leader>w", "<cmd>w<cr>")
    keymap("n", "<leader>h", "<cmd>bprevious<cr>", opts)
    keymap("n", "<leader>l", "<cmd>bnext<cr>", opts)

    keymap('i', 'jj', '<c-c>', opts)
    keymap("n", "<Esc><Esc>", ":<C-u>set nohlsearch<Return>", opts) -- ESC*2 でハイライトやめる

    keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
    keymap('t', 'jj', '<C-\\><C-n>', { noremap = true })
end


-------------
-- OPTIONS --
-------------
-- ファイル
vim.opt.fileencoding = "utf-8" -- エンコーディングをUTF-8に設定
vim.opt.swapfile = false       -- スワップファイルを無効化
vim.opt.helplang = "ja"        -- ヘルプの言語を日本語に設定
vim.opt.hidden = true          -- 非表示のバッファーも編集可能にする

-- カーソルと表示
vim.opt.cursorline = true   -- カーソルの現在行を強調表示
vim.opt.cursorcolumn = true -- カーソルの現在列を強調表示

-- クリップボード共有
-- vim.opt.clipboard:append({ "unnamedplus" }) -- レジスタとクリップボードを共有

-- メニューとコマンド
vim.opt.wildmenu = true -- タブ補完やコマンド補完時にワイルドメニューを表示
vim.opt.cmdheight = 1   -- コマンドラインの表示行数
vim.opt.laststatus = 2  -- 下部にステータスラインを表示
vim.opt.showcmd = true  -- コマンドラインに入力されたコマンドを表示

-- 検索・置換え
vim.opt.hlsearch = true  -- ハイライト検索を有効
vim.opt.incsearch = true -- インクリメンタルサーチを有効
vim.opt.matchtime = 1    -- 入力された文字列がマッチするまでにかかる時間

-- カラースキーム
vim.opt.termguicolors = true -- 24ビットカラーを使用
vim.opt.background = "dark"  -- ダークカラーを使用する

-- インデント
vim.opt.shiftwidth = 4     -- シフト幅を4に設定する
vim.opt.tabstop = 4        -- タブ幅を4に設定する
vim.opt.expandtab = true   -- タブ文字をスペースに置き換える
vim.opt.autoindent = true  -- 自動インデントを有効にする
vim.opt.smartindent = true -- インデントをスマートに調整する

-- 表示
vim.opt.number = true     -- 行番号を表示
vim.opt.wrap = false      -- テキストの自動折り返しを無効に
vim.opt.showtabline = 2   -- タブラインを表示(1:常に表示、2:タブが開かれたときに表示)
vim.opt.visualbell = true -- ビープ音を表示する代わりに画面をフラッシュ
vim.opt.showmatch = true  -- 対応する括弧をハイライト表示

-- インタフェース
vim.opt.winblend = 20      -- ウィンドウの不透明度
vim.opt.pumblend = 20      -- ポップアップメニューの不透明度
vim.opt.showtabline = 2    -- タブラインを表示する設定
vim.opt.signcolumn = "yes" -- サインカラムを表示

-- undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undodir')

-------------
-- AUTOCMD --
-------------
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "init.lua" },
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

--------------
-- PACKAGES --
--------------
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

local packer_installed = pcall(vim.cmd, [[packadd packer.nvim]])
if not packer_installed then
    local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
end

local packer = require "packer"
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})
packer.reset()
packer.startup(function(use)
    -- パッケージマネジャー
    use {
        "wbthomason/packer.nvim",
        opt = true,
        ft = { "lua" },
    }

    -- 入力補助
    use {
        "rhysd/clever-f.vim", -- f の強化
        opt = true,
        keys = { "n", "f" },
        setup = function()
            vim.g.clever_f_across_no_line = 1
        end,
    }

    use {
        "tpope/vim-commentary", -- コメントアウト
        opt = true,
        keys = { "nv", "gc" },
        cmd = "Commentary",
        setup = function()
            vim.keymap.set({ "n", "v", "i" }, "<C-_>", "<cmd>Commentary<cr>")
        end,
    }

    use {
        "jiangmiao/auto-pairs", -- 自動でカッコを閉じる
        opt = true,
        event = { "BufRead", "BufNewFile", "InsertEnter", "CmdlineEnter" },
    }

    use {
        "tpope/vim-surround", -- cs"':''->"" ds":""->_
        opt = true,
        keys = { { "n", "cs" }, { "n", "ds" } },
        requires = { "tpope/vim-repeat", opt = true },
        wants = { "vim-repeat" },
    }


    -- 見た目
    use {
        "echasnovski/mini.indentscope", -- インデントアニメーション
        event = { "InsertEnter" },
        config = function()
            require("mini.indentscope").setup({
                symbol = "▏",
            })
        end,
    }

    -- latex
    use {
        'lervag/vimtex',
        opt = true,
        ft = { "tex" },
        setup = function()
            vim.g.vimtex_compiler_latexmk = { continuous = 0 }
            vim.g.vimtex_syntax_enabled = 0
        end,
    }


    if not vim.g.vscode then
        -- 見た目
        use {
            "folke/tokyonight.nvim", -- カラースキーム
            config = function()
                require("tokyonight").setup({
                    style = "moon",
                    light_style = "moon",
                    transparent = true, -- 背景を半透明
                })
                vim.cmd([[colorscheme tokyonight-storm]])
            end,
        }

        use {
            "nvim-lualine/lualine.nvim", -- ステータスライン
            requires = { "nvim-tree/nvim-web-devicons", opt = true },
            wants = { "nvim-web-devicons" },
            config = function()
                require("lualine").setup {
                }
            end,
        }

        use {
            "kdheepak/tabline.nvim", -- タブライン
            config = function()
                require("tabline").setup {
                }
            end,
        }

        use {
            "nvim-treesitter/nvim-treesitter", -- シンタックスハイライト build-essentialが必要
            opt = true,
            run = ":TSUpdate",
            event = { "BufRead", "BufNewFile", "InsertEnter", "CmdlineEnter" },
            config = function()
                require("nvim-treesitter.configs").setup({
                    -- ensure_installed = 'all',
                    auto_install = true,
                    highlight = {
                        enable = true,       -- syntax highlightを有効にする
                        disable = { 'hoge' } --  無効にする言語
                    },
                    indent = {
                        enable = true, -- インデントを有効
                    },
                })
            end,
        }

        use {
            "folke/noice.nvim", -- ポップアップUI
            opts = true,
            event = { "BufRead", "BufNewFile", "InsertEnter", "CmdlineEnter" },
            module = { "noice" },
            requires = {
                { "MunifTanjim/nui.nvim" },
                {
                    "rcarriga/nvim-notify",
                    module = { "notify" },
                    config = function()
                        require("notify").setup {
                            background_colour = '#000000'
                        }
                    end
                },
            },
            config = function()
                require("noice").setup {
                    -- noice.nvim の設定
                    lsp = {
                        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                        override = {
                            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                            ["vim.lsp.util.stylize_markdown"] = true,
                            ["cmp.entry.get_documentation"] = true,
                        },
                    },
                    -- you can enable a preset for easier configuration
                    presets = {
                        bottom_search = false,        -- use a classic bottom cmdline for search
                        command_palette = false,      -- position the cmdline and popupmenu together
                        long_message_to_split = true, -- long messages will be sent to a split
                        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                        lsp_doc_border = false,       -- add a border to hover docs and signature help
                    },
                }
            end,
        }

        use {
            "nvim-tree/nvim-tree.lua", -- ファイラー
            opts = true,
            cmd = "NvimTreeToggle",
            requires = {
                { "nvim-lua/plenary.nvim",       opt = true },
                { "nvim-tree/nvim-web-devicons", opt = true },
                { "MunifTanjim/nui.nvim",        opt = true },
            },
            wants = {
                'plenary.nvim',
                'nvim-web-devicons',
                'nui.nvim'
            },
            config = function()
                require("nvim-tree").setup({
                    view = {
                        width = 30,
                        side = 'right',
                    },
                    renderer = {
                        highlight_git = true,
                        highlight_opened_files = 'name',
                        icons = {
                            glyphs = {
                                git = {
                                    unstaged = '!',
                                    renamed = '»',
                                    untracked = '?',
                                    deleted = '✘',
                                    staged = '✓',
                                    unmerged = '',
                                    ignored = '◌',
                                },
                            },
                        },
                    },
                    actions = {
                        expand_all = {
                            max_folder_discovery = 100,
                            exclude = { '.git', 'target', 'build' },
                        },
                    },

                    on_attach = 'default'

                })
            end,
            setup = function()
                vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<cr>")
            end,
        }

        use {
            "lewis6991/gitsigns.nvim", -- gitの状況確認
            opt = true,
            event = { "BufRead", "BufNewFile", "InsertEnter", "CmdlineEnter" },
            config = function()
                require("gitsigns").setup({
                    signs = {
                        add          = { text = '+' },
                        change       = { text = '~' },
                        delete       = { text = '_' },
                        topdelete    = { text = '‾' },
                        changedelete = { text = '~_' },
                    },
                    current_line_blame = true,
                })
            end,
        }

        use {
            "mbbill/undotree", -- undo tree
            opts = true,
            cmd = { "UndotreeToggle" },
            setup = function()
                vim.keymap.set("n", "<leader>r", "<cmd>UndotreeToggle<cr>")
            end,
        }

        use {
            "vim-jp/vimdoc-ja",
            opts = true,
            cmd = { "help" },
        }

        -- html
        use {
            "jvanja/vim-bootstrap4-snippets", -- snippet
            opts = true,
            ft = { "html", "js", "jsx" },
        }

        use {
            "alvan/vim-closetag", -- 自動でタグを閉じる
            opts = true,
            ft = { "html", "js", "jsx" },
            setup = function()
                vim.g.closetag_filenames = { "*.html", "*.js" }
            end,
        }

        -- coc
        use {
            "neoclide/coc.nvim",
            branch = "release",
            opt = true,
            event = { "BufRead" },
        }

        use {
            "nvim-telescope/telescope.nvim",
            -- opts = true,
            keys = '<Leader>',
            module = { "telescope" },
            cmd = { "Telescope" },
            requires = {
                { "nvim-telescope/telescope-ghq.nvim",        opt = true },
                { "nvim-telescope/telescope-z.nvim",          opt = true },
                { 'nvim-tree/nvim-web-devicons',              opt = true },
                { 'nvim-lua/plenary.nvim',                    opt = true },
                { 'nvim-telescope/telescope-fzf-native.nvim', opt = true, run = 'make' },
            },
            wants = {
                "telescope-ghq.nvim",
                "telescope-z.nvim",
                'nvim-web-devicons',
                'plenary.nvim',
                'telescope-fzf-native.nvim',
            },
            setup = function()
                local function builtin(name)
                    return function(opt)
                        return function()
                            return require("telescope.builtin")[name](opt or {})
                        end
                    end
                end

                local function extensions(name, prop)
                    return function(opt)
                        return function()
                            local telescope = require "telescope"
                            telescope.load_extension(name)
                            return telescope.extensions[name][prop](opt or {})
                        end
                    end
                end

                vim.keymap.set("n", "<Leader>f:", builtin "command_history" {})
                vim.keymap.set("n", "<Leader>fG", builtin "grep_string" {})
                vim.keymap.set("n", "<Leader>fH", builtin "help_tags" { lang = "ja" })
                vim.keymap.set("n", "<Leader>fm", builtin "man_pages" { sections = { "ALL" } })
                vim.keymap.set("n", "<Leader>fq", extensions("ghq", "list") {})
                vim.keymap.set("n", "<Leader>fz", extensions("z", "list") {})
                vim.keymap.set("n", "<leader>o", builtin "find_files" {})
                vim.keymap.set("n", "<leader>ff", "<cmd>Telescope<cr>")
            end,
            config = function()
                require("telescope").setup {
                    defaults = {},
                    pickers = {
                        find_files = {
                            theme = "dropdown",
                            hidden = true,
                        },
                    },
                    extensions = {},
                }
            end,
        }

        use {
            "dstein64/vim-startuptime",
            opts = true,
            cmd = { "StartupTime" },
        }
    end
    -- Lua
    use {
        "folke/which-key.nvim",
        event = "VimEnter",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {}
        end,
    }
    if not packer_installed then
        require("packer").sync()
    end
end)
