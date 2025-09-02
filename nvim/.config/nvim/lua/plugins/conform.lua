return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			-- TODO: Should I replace conform by none-ls?
			go = { "goimports", "gofmt" },
			javascript = { "biome-check", "biome-organize-imports" },
			json = { "biome" },
			kotlin = { "ktfmt" },
			lua = { "stylua" },
			python = { "ruff_format", "ruff_organize_imports", "ruff_fix" }, -- isort, black?
			rust = { "rustfmt" },
			sh = { "shfmt" },
			typescript = { "biome-check", "biome-organize-imports" },
			["_"] = { "trim_whitespace" },
			["*"] = { "codespell" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},

		default_format_opts = {
			lsp_format = "fallback",
		},

		formatters = {
			shfmt = {
				append_args = { "-i", "2", "-sr" },
			},
		},

		notify_on_error = true,
	},
}
