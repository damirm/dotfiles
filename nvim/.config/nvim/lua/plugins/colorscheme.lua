return {
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		enabled = true,
		lazy = false,
		priority = 1000,
		config = function()
			require("github-theme").setup({
				-- ...
			})

			vim.cmd.colorscheme("github_dark_default")
		end,
	},
	{
		"mcauley-penney/techbase.nvim",
		priority = 1000,
		enabled = false,
		config = function()
			vim.cmd.colorscheme("techbase")
		end,
	},
	{
		"catppuccin/nvim",
		enabled = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"rose-pine/neovim",
		enabled = false,
		name = "rose-pine",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		"AlexvZyl/nordic.nvim",
		enabled = false,
		priority = 1000,
		config = function()
			require("nordic").load()
			vim.cmd.colorscheme("nordic")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		enabled = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("kanagawa")
		end,
	},
}
