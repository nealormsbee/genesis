local function explore()
  vim.cmd('Ex')
end

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', explore)

vim.keymap.set('n', '<leader>q', 'I// <Esc>')
