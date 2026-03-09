local default_opts = { noremap = true, silent = true }

local opts = function(desc)
	return vim.tbl_deep_extend("force", default_opts, { desc = desc })
end

-- Window movements
vim.keymap.set("n", "<c-h>", "<c-w>h", opts("Activate left window"))
vim.keymap.set("n", "<c-j>", "<c-w>j", opts("Activate window below"))
vim.keymap.set("n", "<c-k>", "<c-w>k", opts("Activate upper window"))
vim.keymap.set("n", "<c-l>", "<c-w>l", opts("Activate right window"))
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", opts("Vertical split"))
vim.keymap.set("n", "<leader>sh", ":hsplit<CR>", opts("Horizontal split"))

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", opts("Increase window height"))
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", opts("Decrease window height"))
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts("Decrease window width"))
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts("Increase window width"))

-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", default_opts)
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", default_opts)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", default_opts)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", default_opts)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv-gv", default_opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv-gv", default_opts)

-- Tabs movement
vim.keymap.set("n", "L", ":BufferLineCycleNext<cr>", opts("Next tab"))
vim.keymap.set("n", "H", ":BufferLineCyclePrev<cr>", opts("Prev tab"))
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>t>", ":tabm +1<cr>", opts("Move tab to right"))
vim.keymap.set("n", "<leader>t<", ":tabm -1<cr>", opts("Move tab to left"))

-- nvim-tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", opts("Toggle file explorer"))
vim.keymap.set("n", "<CR>", ":NvimTreeFindFile<cr>", opts("Focus current file in file exporer"))
vim.keymap.set("n", "-", "<CMD>Oil<CR>", opts("Open parent directory"))

vim.keymap.set("n", "Y", '"*y', default_opts)
vim.keymap.set("v", "Y", '"*y', default_opts)
vim.keymap.set("x", "<leader>p", '"_dP', opts("Paste without yanking"))
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', opts("Delete without yanking"))

-- save / quit
vim.keymap.set("n", "<leader>w", ":w<cr>", default_opts)
vim.keymap.set("n", "<leader>q", ":q<cr>", default_opts)

-- diagnostics
vim.keymap.set("n", "[d", ":lua vim.diagnostic.goto_prev()<cr>", default_opts)
vim.keymap.set("n", "]d", ":lua vim.diagnostic.goto_next()<cr>", default_opts)
vim.keymap.set("n", "[e", ":lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>", default_opts)
vim.keymap.set("n", "]e", ":lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>", default_opts)

vim.keymap.set("n", "<leader>lg", ":lua Snacks.lazygit()<cr>", default_opts)
