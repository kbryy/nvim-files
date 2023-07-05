local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set

vim.g.mapleader = " "
keymap('i', 'jj', '<c-c>', opts)

keymap({ "n", "v" }, "<c-j>", "}", opts)
keymap({ "n", "v" }, "<c-k>", "{", opts)
keymap({ "n", "v" }, "<c-h>", "_", opts)
keymap({ "n", "v" }, "<c-l>", "$", opts)
keymap({ "n", "v" }, "<c-;>", "%", opts)

if vim.g.vscode then
    keymap("n", "<leader>o", "<cmd>call VSCodeNotify('workbench.action.quickOpen')<cr>")
    keymap("n", "<leader>d", "<cmd>call VSCodeNotify('workbench.action.files.save')<cr>")
    keymap("n", "<leader>h", "<cmd>call VSCodeNotify('workbench.action.previousEditor')<cr>")
    keymap("n", "<leader>l", "<cmd>call VSCodeNotify('workbench.action.nextEditor')<cr>")
else
    keymap("n", "<leader>o", function() require("telescope.builtin").find_files { hidden = true } end)
    keymap("n", "<leader>w", "<cmd>w<cr>")

    keymap("n", "<leader>h", "<C-w>h<cr>", opts)
    keymap("n", "<leader>j", "<C-w>j<cr>", opts)
    keymap("n", "<leader>k", "<C-w>k<cr>", opts)
    keymap("n", "<leader>l", "<C-w>l<cr>", opts)
    keymap("n", "<C-n>", "<cmd>bnext<cr>", opts)
    keymap("n", "<C-p>", "<cmd>bprevious<cr>", opts)
    keymap("n", "<leader>mm", "<cmd>NeoTreeShowToggle<cr>", opts)
    keymap("n", "<M-m>", "<cmd>NeoTreeShowToggle<cr>", opts)
    keymap("n", "<C-_>", "<cmd>Commentary<cr>", opts)

    -- keymap('n', 'e', '<cmd>lua vim.diagnostic.open_float()<cr>')
    -- keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    -- keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    -- keymap('n', 'q', '<cmd>lua vim.diagnostic.setloclist()<cr>')

    -- keymap('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>')
    -- keymap('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<cr>')
    -- keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    -- keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    -- keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    -- keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    -- keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    -- keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    -- keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    -- keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<cr>')
    -- keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    -- keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
end
