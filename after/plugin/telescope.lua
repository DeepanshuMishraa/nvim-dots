local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-f>', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', '<leader>fs',function()
	builtin.grep_string({search = vim.fn.input("Grep > ")})
end)

