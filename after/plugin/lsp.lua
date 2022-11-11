local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local keymap = require("prolo.keymap")
local nnoremap = keymap.nnoremap
local inoremap = keymap.inoremap

local luasnip = require("luasnip")

-- Set up nvim-cmp.
local cmp = require'cmp'

local cmp_next_item_mapping = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    elseif has_words_before() then
        cmp.complete()
    else
        fallback()
    end
end, { "i", "s" })

local cmp_prev_item_mapping = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end, { "i", "s" })

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        ['<Tab>'] = cmp_next_item_mapping,
        ['<C-j>'] = cmp_next_item_mapping,

        ['<S-Tab>'] = cmp_prev_item_mapping,
        ['<C-k>'] = cmp_prev_item_mapping,

        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

local function config(_config)
    return vim.tbl_deep_extend("force", {
        on_attach = function()
            nnoremap("gd", function() vim.lsp.buf.definition() end)
            nnoremap("K", function() vim.lsp.buf.hover() end)
            nnoremap("[d", function() vim.diagnostic.goto_next() end)
            nnoremap("]d", function() vim.diagnostic.goto_prev() end)
            nnoremap("gl", function() vim.diagnostic.open_float() end)
            nnoremap("<leader>ca", function() vim.lsp.buf.code_action() end)
            nnoremap("gr", function() vim.lsp.buf.references() end)
            nnoremap("<leader>rn", function() vim.lsp.buf.rename() end)
            inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
        end
    }, _config or {})
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").sumneko_lua.setup(config({ capabilities = capabilities }))

require("lspconfig").elixirls.setup(config({
    cmd = {os.getenv("HOME") .. "/lsp/elixir-ls/language_server.sh"},
    capabilitties = capabilities
}))

require("lspconfig").ccls.setup(config({ capabilities = capabilities }))

require("lspconfig").pyright.setup(config({ capabilities = capabilities }))

require("lspconfig").solargraph.setup(config({ capabilities = capabilities }))

require("lspconfig").rust_analyzer.setup(config({ capabilities = capabilities }))

require("lspconfig").csharp_ls.setup(config({ capabilities = capabilities }))

require("lspconfig").tailwindcss.setup(config({ capabilities = capabilities }))
