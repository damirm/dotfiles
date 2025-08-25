return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"ibhagwan/fzf-lua",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(mode, keys, func, desc)
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("n", "K", vim.lsp.buf.hover, "Hover")
					map("n", "C-]", vim.lsp.buf.definition, "Go to Definition")
					map("n", "<leader>gt", vim.lsp.buf.type_definition, "Go to Type Definition")
					map("n", "<leader>gs", vim.lsp.buf.signature_help, "Signature Help")
					map("n", "<leader>gl", vim.lsp.buf.signature_help, "Signature Help")

					map("n", "<leader>gr", function()
						require("fzf-lua").lsp_references()
					end, "References")

					map("n", "<leader>gi", function()
						require("fzf-lua").lsp_implementations()
					end, "Implementations")

					map("n", "<leader>gd", function()
						require("fzf-lua").lsp_definitions()
					end, "Definitions")

					map("n", "<leader>gD", function()
						require("fzf-lua").lsp_declarations()
					end, "Declarations")

					map("n", "<leader>gt", function()
						require("fzf-lua").lsp_typedefs()
					end, "Type Definitions")

					map("n", "<leader>ca", function()
						require("fzf-lua").lsp_code_actions()
					end, "Type Definitions")

					map("n", "<leader>rr", vim.lsp.buf.rename, "Rename")
					map("n", "<leader>rf", vim.lsp.buf.format, "Format")

					-- map("n", "<leader>gd", vim.lsp.buf.definition, "Go to Definition")
					-- map("n", "<leader>gD", vim.lsp.buf.declaration, "Go to Declaration")
					--
					-- map("n", "<leader>gr", function()
					-- 	require("trouble").toggle("lsp_references")
					-- end, "References")

					-- map("n", "<leader>gi", function()
					-- 	require("trouble").toggle("lsp_implementations")
					-- end, "Implementations")

					-- map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
				end,
			})

			local runtime_path = vim.split(package.path, ";")
			table.insert(runtime_path, "lua/?.lua")
			table.insert(runtime_path, "lua/?/init.lua")

			local current_path = vim.fn.getcwd()
			local python_extra_paths = (string.find(current_path, "cloudia") or string.find(current_path, "arcadia"))
					and { "~/cloudia", "~/arcadia" }
				or {}

			local servers = {
				bashls = {
					install_opts = { "bash-language-server" },
					filetypes = { "sh", "bash", "zsh" },
				},
				tailwindcss = {
					install_opts = { "tailwindcss-language-server" },
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"svelte",
					},
				},
				biome = {},
				eslint = {},
				gopls = {},
				-- TODO: Replace it with ruff.
				basedpyright = {
					settings = {
						basedpyright = {
							analysis = {
								autoImportCompletions = true,
								diagnosticMode = "openFilesOnly",
								inlayHints = {
									callArgumentNames = true,
								},
								extraPaths = python_extra_paths,
							},
						},
					},
				},
				rust_analyzer = {},
				ts_ls = {
					filetypes = {
						"typescript",
						"javascript",
						"typescriptreact",
						"javascriptreact",
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using (most likely LuaJIT)
								version = "LuaJIT",
								-- Setup your lua path
								path = runtime_path,
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
							-- Do not send telemetry data containing a randomized but unique identifier
							telemetry = { enable = false },
						},
					},
				},
				jsonls = {
					filetypes = { "json", "jsonc" },
				},
				yamlls = {},
				html = {},

				-- ruff = {},
				-- nimlsp = {},
				-- sqls = {},
				-- zls = {},
				-- clangd = {},
				-- cmake = {},
				-- ktfmt = {},
			}

			local ensure_installed = {
				"stylua",
				"shfmt",
				"ty",
				"salt-lint",
				"codespell",
			}

			for server, config in pairs(servers) do
				table.insert(ensure_installed, config.install_opts or server)
			end

			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
			})

			for server, config in pairs(servers) do
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end

			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.HINT] = " ",
					},
				},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})
		end,
	},
}
