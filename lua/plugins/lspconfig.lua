local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
}

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "<CR>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    keymap(bufnr, "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    keymap(bufnr, "n", "<leader>l", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
    keymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)

    if client.supports_method "textDocument/inlayHint" then
        vim.lsp.inlay_hint.enable(true)
    end
end

M.toggle_inlay_hints = function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end

function M.common_capabilities()
    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if status_ok then
        return cmp_nvim_lsp.default_capabilities()
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    return capabilities
end


function M.config()
    local lspconfig = require "lspconfig"
    local icons = require "icons"

    local servers = {
        "lua_ls",
        "cssls",
        "html",
    }

    vim.diagnostic.config {
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
                [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
            },
        },
        virtual_text = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            header = "",
            prefix = "",
        },
    }

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    for _, server in pairs(servers) do
        local opts = {
            on_attach = M.on_attach,
            capabilities = M.common_capabilities(),
        }

        local require_ok, settings = pcall(require, "lspsettings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end

        lspconfig[server].setup(opts)
    end
end

return M
