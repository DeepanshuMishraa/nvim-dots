local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier.with({
            extra_filetypes = { "svelte" },
        }),
        null_ls.builtins.diagnostics.eslint,
    },
})

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})

local format_on_save = vim.api.nvim_create_augroup("FormatOnSave", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_on_save,
    pattern = "*",
    callback = function()
        vim.lsp.buf.format()
    end,
})