return {
    'neovim/nvim-lspconfig',
    config = function()
        local lspconfig = require('lspconfig')
        -- gopls
        -- {{{ https://github.com/neovim/nvim-lspconfig/issues/2733
        -- loading module to provide config for a server following steps from guide here
        -- https://github.com/neovim/nvim-lspconfig/blob/ede4114e1fd41acb121c70a27e1b026ac68c42d6/doc/lspconfig.txt#L326
        local configs = require 'lspconfig.configs'

        -- copy paste from 
        -- https://github.com/neovim/nvim-lspconfig/blob/ede4114e1fd41acb121c70a27e1b026ac68c42d6/lua/lspconfig/server_configurations/gopls.lua
        local util = require 'lspconfig.util'
        local async = require 'lspconfig.async'
        -- -> the following line fixes it - mod_cache initially set to value that you've got from `go env GOMODCACHE` command
        local mod_cache = '/root/go/pkg/mod'

        -- setting the config for gopls, the contents below is also copy-paste from
        -- https://github.com/neovim/nvim-lspconfig/blob/ede4114e1fd41acb121c70a27e1b026ac68c42d6/lua/lspconfig/server_configurations/gopls.lua
        configs.gopls = {
            default_config = {
                cmd = { 'gopls' },
                filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
                root_dir = function(fname)
                    -- see: https://github.com/neovim/nvim-lspconfig/issues/804
                    if not mod_cache then
                        local result = async.run_command 'go env GOMODCACHE'
                        if result and result[1] then
                            mod_cache = vim.trim(result[1])
                        end
                    end
                    if fname:sub(1, #mod_cache) == mod_cache then
                        local clients = vim.lsp.get_active_clients { name = 'gopls' }
                        if #clients > 0 then
                            return clients[#clients].config.root_dir
                        end
                    end
                    return util.root_pattern 'go.work'(fname) or util.root_pattern('go.mod', '.git')(fname)
                end,
                single_file_support = true,
            },
            docs = {
                description = [[
  https://github.com/golang/tools/tree/master/gopls

  Google's lsp server for golang.
  ]],
                default_config = {
                    root_dir = [[root_pattern("go.work", "go.mod", ".git")]],
                },
            },
        } -- }}}
        lspconfig.gopls.setup({
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                    -- root_dir = function(fname)
                    --     -- see: https://github.com/neovim/nvim-lspconfig/issues/804
                    --     local mod_cache = vim.trim(vim.fn.system 'go env GOMODCACHE')
                    --     if fname:sub(1, #mod_cache) == mod_cache then
                    --         local clients = vim.lsp.get_active_clients { name = 'gopls' }
                    --         if #clients > 0 then
                    --             return clients[#clients].config.root_dir
                    --         end
                    --     end
                    --     return util.root_pattern 'go.work'(fname) or util.root_pattern('go.mod', '.git')(fname)
                    -- end,
                },

            })

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        -- NOTE: this keymap overrides my keymap <Leader>e
        -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '<space>E', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<space>f', function()
                    vim.lsp.buf.format { async = true }
                end, opts)
        end,
    })
    end,
}
