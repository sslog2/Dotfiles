return {
   -- nvim-dap core
   {
      "mfussenegger/nvim-dap",
      config = function()
         local dap = require("dap")
         -- Python adapter configuration
         dap.adapters.python = {
            type = "executable",
            command = "python",
            args = { "-m", "debugpy.adapter" },
         }

         -- Python configuration
         dap.configurations.python = {
            {
               type = "python", -- Adapter type
               request = "launch",
               name = "Launch file",
               program = "${file}", -- This will debug the current file
               pythonPath = function()
                  return "/usr/bin/python" -- Adjust according to your Python environment
               end,
            },
         }
      end,
   },
   -- nvim-dap-ui with nvim-nio as a dependency
   {
      "rcarriga/nvim-dap-ui",
      dependencies = {
         "mfussenegger/nvim-dap",
         "nvim-neotest/nvim-nio", -- Add this line
      },
      config = function()
         require("dapui").setup()
         local dap = require("dap")
         dap.listeners.after.event_initialized["dapui_config"] = function()
            require("dapui").open()
         end
         dap.listeners.before.event_terminated["dapui_config"] = function()
            require("dapui").close()
         end
         dap.listeners.before.event_exited["dapui_config"] = function()
            require("dapui").close()
         end
      end,
   },
   -- Optional: Virtual text for nvim-dap
   {
      "theHamsta/nvim-dap-virtual-text",
      dependencies = { "mfussenegger/nvim-dap" },
      config = function()
         require("nvim-dap-virtual-text").setup()
         vim.fn.sign_define(
            "DapBreakpoint",
            { text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
         )
      end,
   },
}
