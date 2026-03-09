return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        "nvim-treesitter",
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('lualine').setup()
    end
}
