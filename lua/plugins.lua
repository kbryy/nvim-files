-- packer.nvimのインストール状態を確認し自動でインストール
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    -- local install_path = fn.stdpath("data") .. "~/.config/nvim/plugin/packer.nvim"
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

    -- 入力補助
    use("rhysd/clever-f.vim")              -- f の強化
    use("tpope/vim-commentary")            -- コメントアウト
    use("jiangmiao/auto-pairs")            -- 自動でカッコを閉じる
    use({
        "tpope/vim-surround",              -- cs"':''->"" ds":""->_
        "tpope/vim-repeat",                -- surroundの繰り返し
    })

    use('lervag/vimtex')

    -- 見た目
    use("echasnovski/mini.indentscope")    -- インデントアニメーション

    if not vim.g.vscode then
        -- 見た目
        use("folke/tokyonight.nvim")     -- カラースキーム
        use({
            "nvim-lualine/lualine.nvim", -- ステータスライン
            requires = { "nvim-tree/nvim-web-devicons"},
        })
        use("kdheepak/tabline.nvim")           -- タブライン
        use({
            "nvim-treesitter/nvim-treesitter", -- シンタックスハイライト build-essentialが必要
            -- run = ":TSUpdate",
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

        use( "mbbill/undotree") -- undo tree
        use({"vim-jp/vimdoc-ja", opt = true})

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
    end
end)
