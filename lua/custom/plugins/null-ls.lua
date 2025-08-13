return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require 'null-ls'
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.clang_format.with {
            extra_args = { '-style=file' }, -- 强制使用项目中的 .clang-format 文件
          },
        },
      }

      -- 设置快捷键
      vim.keymap.set('n', '<Leader>cf', function()
        vim.lsp.buf.format { async = true }
      end, { desc = 'Format with .clang-format' })

      -- 可选：保存时自动格式化（仅针对 C/C++ 文件）
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = { '*.c', '*.cpp', '*.h', '*.hpp' },
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end,
  },
}
