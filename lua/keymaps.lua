local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
-- local term_opts = { silent = true }

vim.g.mapleader = " "

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
    keymap("n", "<leader>o", function() require("telescope.builtin").find_files { hidden = true } end)
    keymap("n", "<leader>l", "<cmd>bnext<cr>", opts)
    keymap("n", "<leader>h", "<cmd>bprevious<cr>", opts)

    keymap('i', 'jj', '<c-c>', opts)
    keymap("n", "<C-b>", "<cmd>NeoTreeShowToggle<cr>", opts)
    keymap("n", "<C-_>", "<cmd>Commentary<cr>", opts)
end
