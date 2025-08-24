return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "FZF Files",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "FZF Live Grep",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "FZF Buffers",
		},
	},
	opts = {},
}
