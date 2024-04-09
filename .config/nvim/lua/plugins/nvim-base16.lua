return {
    'JoshPorter/nvim-base16',
    config = function()
        -- BLACK='#2f2a40'
        -- BLACK='#393940'
        -- RED='#f227bc'
        -- GREEN='#b1f250'
        -- YELLOW='#d9d0a7'
        -- BLUE='#359af2'
        -- PURPLE='#5944a6'
        -- CYAN='#50bff2'
        -- WHITE='#f2f2f2'
        -- BRIGHT_BLACK='#5b5573'
        -- BRIGHT_BLACK='#7e7d84'
        -- BRIGHT_RED='#f24fcf'
        -- BRIGHT_GREEN='#c4f25b'
        -- BRIGHT_YELLOW='#e0d8b0'
        -- BRIGHT_BLUE='#5faaf2'
        -- BRIGHT_PURPLE='#7c6db6'
        -- BRIGHT_CYAN='#6fd2f2'
        -- BRIGHT_WHITE='#f2f2f2'
        require('nvim-base16').setup({
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
        })
    end
}
