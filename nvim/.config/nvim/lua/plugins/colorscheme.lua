return {
	{
		"mcauley-penney/techbase.nvim",
		enabled = true,
		priority = 1000,
		config = function(_, opts)
			vim.cmd.colorscheme("techbase")
		end,
	},
	{
		"catppuccin/nvim",
		enabled = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin")
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
}
