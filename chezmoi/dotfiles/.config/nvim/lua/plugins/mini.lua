return {
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.pairs").setup()
			require("mini.comment").setup()
			require("mini.splitjoin").setup()
		end,
	},
}
