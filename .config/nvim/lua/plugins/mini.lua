return {
    'echasnovski/mini.nvim',
    version = '*', -- '*' for stable
    config = function()
        local base16_darken = {
            base00 = '#2f2a40',
            base01 = '#393940',
            base02 = '#5b5573',
            base03 = '#7e7d84',
            base04 = '#d9d0a7',
            base05 = '#e0d8b0',
            base06 = '#f2f2f2',
            base07 = '#f2f2f2',
            base08 = '#f227bc',
            base09 = '#f24fcf',
            base0A = '#c4f25b',
            base0B = '#b1f250',
            base0C = '#50bff2',
            base0D = '#359af2',
            base0E = '#5944a6',
            base0F = '#7c6db6',
        }
        require('mini.base16').setup({
            palette = base16_darken,
            use_cterm = true,
            plugins = {
                default = true,
                ['echasnovski/mini.nvim'] = true,
            },
        })
    end,
}
