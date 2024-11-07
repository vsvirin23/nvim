vim.cmd "let mapleader = ' '"

local function keymap(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

keymap("n", "<ESC>", ":nohl<CR>")
keymap("n", "<leader>ww", ":w<CR>")
keymap("n", "<leader>wa", ":wa<CR>")
keymap("n", "<leader>wq", ":wqa<CR>")
keymap("n", "<leader>q", "<C-w>c")
keymap("n", "<C-Up>", "<C-w>w")
keymap("n", "<C-Down>", "<C-w>w")
keymap("n", "<C-Left>", ":split<CR>")
keymap("n", "<C-Right>", ":vsplit<CR>")

keymap("n", "-", "<CMD>Oil<CR>")

keymap("n", "<leader>tt", ":Telescope find_files<CR>")
keymap("n", "<leader>tb", ":Telescope buffers<CR>")
keymap("n", "<leader>t.", ":Telescope resume<CR>")
keymap("n", "<leader>th", ":Telescope help_tags<CR>")
keymap("n", "<leader>tc", ":Telescope colorscheme<CR>")
keymap("n", "<leader>to", ":Telescope oldfiles<CR>")
keymap("n", "<leader>tg", ":Telescope live_grep<CR>")
keymap("n", "<leader>ts", ":Telescope lsp_document_symbols<CR>")

keymap("n", "]h", "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>")
keymap("n", "[h", "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>")
keymap("n", "<leader>hp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>")
keymap("n", "<leader>hr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>")
keymap("n", "<leader>hs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>")
keymap("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>")
keymap("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>")
keymap("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>")
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>")
keymap("n", "<leader>gg", "<cmd>Neogit<CR>")
