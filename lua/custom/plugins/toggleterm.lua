return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    open_mapping = '<C-t>',
    direction = 'float',
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    -- 定义快捷键
    local opt = { noremap = true, silent = true }
    vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opt)
    vim.keymap.set('t', 'jk', '<C-\\><C-n>:q<CR>', opt) -- 关闭浮动窗口
  end,
}
