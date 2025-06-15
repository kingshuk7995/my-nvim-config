local plugins = {
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings("dap")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "codelldb",
        "pyright",          -- LSP for Python
        "black",            -- Formatter for Python
        "isort",            -- Import sorter for Python
        "flake8",           -- Linter for Python
        "debugpy",          -- Debugger for Python
        "cmake-language-server", -- LSP for CMake
      },
    },
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
    end,
  },

  {
    "Shatur/neovim-cmake",
    ft = { "cpp", "cmake" },
    config = function()
      require("cmake").setup {
        build_dir = "build",
        dap_configurations = {
          lldb = {
            type = "lldb",
            request = "launch",
            name = "Launch via CMake",
            program = "${buildDir}/${target}",
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
          },
        },
      }
    end,
  },
}

return plugins

