local api = vim.api

-- TODO: What is that?
api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "quickfix" },
	command = "nnoremap <buffer> <CR> <CR>",
})
