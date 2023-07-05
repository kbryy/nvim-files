-- packer.nvimのインストール状態を確認し自動でインストール
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
ensure_packer() -- packer_bootstrap


return require("packer").startup(function(use)
    -- パッケージマネジャー
    use({ "wbthomason/packer.nvim", opt = true })

    -- 見た目
    use("folke/tokyonight.nvim")     -- カラースキーム
    use({
        "nvim-lualine/lualine.nvim", -- ステータスライン
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
    })
    use("kdheepak/tabline.nvim")           -- タブライン
    use("echasnovski/mini.indentscope")    -- インデントアニメーション
    use({
        "nvim-treesitter/nvim-treesitter", -- シンタックスハイライト
        run = ":TSUpdate",
    })
    use({
        "folke/noice.nvim", -- ポップアップUI
        config = function()
            require("noice").setup({})
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    })
    use({
        "nvim-neo-tree/neo-tree.nvim", -- ファイラー
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    })
    use({
        "lewis6991/gitsigns.nvim", -- gitの状況確認
        config = function()
            require("gitsigns").setup()
        end,
    })

    -- 入力補助
    use("rhysd/clever-f.vim")              -- f の強化
    use("tpope/vim-commentary")            -- コメントアウト
    use("jiangmiao/auto-pairs")            -- 自動でカッコを閉じる
    use({
        "tpope/vim-surround",              -- cs"':''->"" ds":""->_
        "tpope/vim-repeat",                -- surroundの繰り返し
    })
    use({ "mbbill/undotree", opt = true }) -- undo tree
    -- use({"vim-jp/vimdoc-ja", opt = true})

    -- html
    use({ "jvanja/vim-bootstrap4-snippets", opt = true, ft = { "html" } }) -- snippet
    use({ "alvan/vim-closetag", opt = true, ft = { "html" } })             -- 自動でタグを閉じる

    -- coc
    use({
        "neoclide/coc.nvim",
        branch = "release",
    })

    -- fzf telescoop
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")

    -- -- LSP、DAP、リンター、フォーマッター
    -- use({
    --     "williamboman/mason.nvim",  -- 総合管理インターフェース
    --     "williamboman/mason-lspconfig.nvim",
    --     "neovim/nvim-lspconfig",
    -- })
    -- use({
    --     "jose-elias-alvarez/null-ls.nvim",  -- リンター, フォーマッター
    --     requires = "nvim-lua/plenary.nvim",
    -- })
    -- -- 補完系プラグイン
    -- use({
    --     "hrsh7th/cmp-nvim-lsp",
    --     "hrsh7th/cmp-buffer",
    --     "hrsh7th/cmp-path",
    --     "hrsh7th/cmp-cmdline",
    --     "hrsh7th/nvim-cmp",
    --     "onsails/lspkind.nvim",
    --     -- "hrsh7th/vim-vsnip",
    -- })
    use('lervag/vimtex')
end)
