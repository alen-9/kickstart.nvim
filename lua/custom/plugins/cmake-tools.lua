return {
  'Civitasv/cmake-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('cmake-tools').setup {
      cmake_command = 'cmake', -- 指定 cmake 命令路径
      ctest_command = 'ctest', -- 指定 ctest 命令路径
      cmake_use_preset = true,
      cmake_regenerate_on_save = true, -- 保存 CMakeLists.txt 时自动重新生成
      cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=1' }, -- `CMakeGenerate` 调用时传递的参数
      cmake_build_options = {}, -- `CMakeBuild` 调用时传递的参数
      cmake_build_directory = 'build',
      cmake_soft_link_compile_commands = true, -- 自动从编译命令文件创建软链接到项目根目录
      cmake_compile_commands_from_lsp = false, -- 通过 LSP 自动设置编译命令文件位置，启用前请确保 `cmake_soft_link_compile_commands` 为 false
      cmake_kits_path = nil, -- 全局 CMake kits 路径配置，详情见 CMakeKits 文档
      cmake_variants_message = { -- 显示构建变体消息的控制
        short = { show = true }, -- 是否显示简短消息
        long = { show = true, max_length = 40 }, -- 是否显示完整消息及其最大长度
      },
      cmake_dap_configuration = { -- debug settings for cmake
        name = 'cpp',
        type = 'codelldb',
        request = 'launch',
        stopOnEntry = false,
        runInTerminal = true,
        console = 'integratedTerminal',
      },

      cmake_executor = { -- executor to use
        name = 'quickfix', -- name of the executor
        opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
        default_opts = { -- a list of default and possible values for executors
          quickfix = {
            show = 'always', -- "always", "only_on_error"
            position = 'botright', -- "bottom", "top", "belowright"
            size = 10,
            encoding = 'utf-8',
            auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
          },
          toggleterm = {
            direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float'
            close_on_exit = true, -- whether close the terminal when exit
            auto_scroll = true, -- whether auto scroll to the bottom
          },
          overseer = {},
          terminal = {
            name = 'CMake Terminal',
            prefix_name = '[CMakeTools]: ', -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
            split_direction = 'horizontal', -- "horizontal", "vertical"
            split_size = 6,

            -- Window handling
            single_terminal_per_instance = true, -- Single viewport, multiple windows
            single_terminal_per_tab = true, -- Single viewport per tab
            keep_terminal_static_location = true, -- Static location of the viewport if avialable

            -- Running Tasks
            start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
            focus = false, -- Focus on terminal when cmake task is launched.
            do_not_add_newline = true, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
          },
        },
      },
      cmake_runner = {
        -- name = "terminal",
        name = 'toggleterm',
        opts = {},
        default_opts = { -- a list of default and possible values for runners
          quickfix = {
            show = 'always', -- "always", "only_on_error"
            position = 'belowright', -- "bottom", "top"
            size = 6,
            encoding = 'utf-8',
            auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
          },
          toggleterm = {
            -- direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
            -- direction = "tab", -- 'vertical' | 'horizontal' | 'tab' | 'float'
            -- close_on_exit = false, -- whether close the terminal when exit
            direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float'
            close_on_exit = true, -- whether close the terminal when exit
            singleton = false, -- single instance, autocloses the opened one, if present
            auto_scroll = false, -- whether auto scroll to the bottom
          },
          overseer = {},
          terminal = {
            name = 'CMake Terminal',
            prefix_name = '[CMakeTools]: ', -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
            split_direction = 'horizontal', -- "horizontal", "vertical"
            split_size = 6,

            -- Window handling
            single_terminal_per_instance = true, -- Single viewport, multiple windows
            single_terminal_per_tab = true, -- Single viewport per tab
            keep_terminal_static_location = true, -- Static location of the viewport if avialable

            -- Running Tasks
            start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
            focus = false, -- Focus on terminal when cmake task is launched.
            do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
          },
        },
      },
      cmake_notifications = { -- 通知配置
        runner = { enabled = true },
        executor = { enabled = true },
        spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }, -- 进度显示图标
        refresh_rate_ms = 100, -- 图标切换频率
      },
      cmake_virtual_text_support = true, -- 开启虚拟文本支持，展示与当前文件相关的构建目标（位于编辑器右边缘）

      vim.keymap.set('n', 'cmg', '<cmd>wa<CR><cmd>CMakeGenerate<CR>', { silent = true, desc = 'CMakeGenerate' }),
      vim.keymap.set('n', 'cmb', '<cmd>wa<CR><cmd>CMakeBuild<CR>', { silent = true, desc = 'CMakeBuild' }),
      vim.keymap.set('n', 'cmr', '<cmd>wa<CR><cmd>CMakeRun<CR>', { silent = true, desc = 'CMakeRun' }),
      vim.keymap.set('n', 'cms', '<cmd>wa<CR><cmd>CMakeStopRunner<CR>', { silent = true, desc = 'CMakeStopRunner' }),
    }
  end,
}
