--------------
-- PACKAGES --
--------------
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
    config = function()
      vim.opt.updatetime = 100
      vim.opt.signcolumn = "yes"
      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end
      local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
      local keyset = vim.keymap.set
      keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
      keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
      keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
      keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
      keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})
      keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
      keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

      -- コードのジャンプナビゲーション
      keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
      keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
      keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
      keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

      -- プレビューウィンドウでドキュメントを表示するために K を使用します
      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end
      keyset("n", "<space>k", '<CMD>lua _G.show_docs()<CR>', {silent = true})

      vim.api.nvim_create_augroup("CocGroup", {})
      vim.api.nvim_create_autocmd("CursorHold", {
        group = "CocGroup",
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold"
      })


    end,
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
  -- Lua
  use {
    "folke/which-key.nvim",
    opt = true,
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
