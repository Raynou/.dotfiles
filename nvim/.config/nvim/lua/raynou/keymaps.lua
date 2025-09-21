local opts = { noremap=true, silent=true }

vim.keymap.set('n', '<leader>w', ':w<CR>', opts)
vim.keymap.set('n', '<leader>wq', ':wq<CR>', opts)
vim.keymap.set('n', '<leader>qq', ':q!<CR>', opts)
vim.keymap.set('n', 'F', function()
  -- Save the current position
  local pos = vim.api.nvim_win_get_cursor(0)

  -- Go to first line and start visual mode
  vim.cmd('1')
  vim.cmd('normal! v')

  -- Go to last line and indendt
  vim.cmd('$')
  vim.cmd('normal! =')

  -- Return to original position
  vim.api.nvim_win_set_cursor(0, pos)
end, opts)
vim.keymap.set('i', 'ii', '<Esc>', opts)

-- Diagnostics keymaps
vim.keymap.set('n', 'E', vim.diagnostic.open_float, opts)

