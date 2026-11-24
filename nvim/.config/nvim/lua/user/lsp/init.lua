local handlers = require "user.lsp.handlers"
handlers.setup()
vim.lsp.config("*", { capabilities = handlers.capabilities, on_attach = handlers.on_attach })

local registry = require "mason-registry"
local packages = {
  lua_ls = "lua-language-server",
  pyright = "pyright",
  ts_ls = "typescript-language-server",
  clangd = "clangd",
  bashls = "bash-language-server",
}

local group = vim.api.nvim_create_augroup("UserLspInstall", { clear = true })
for server, package in pairs(packages) do
  local config = vim.lsp.config[server]
  if vim.fn.executable(config.cmd[1]) == 1 then
    vim.lsp.enable(server)
  else
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = config.filetypes,
      callback = function(event)
        if vim.bo[event.buf].buftype ~= "" then return end
        if vim.fn.executable(config.cmd[1]) == 1 then
          vim.lsp.enable(server)
          return true
        end
        registry.refresh(vim.schedule_wrap(function()
          local ok, pkg = pcall(registry.get_package, package)
          if not ok then
            vim.notify("Mason could not find " .. package .. ". See :MasonLog", vim.log.levels.ERROR)
          elseif pkg:is_installed() then
            vim.lsp.enable(server)
          elseif not pkg:is_installing() then
            pkg:install({}, vim.schedule_wrap(function(success)
              if success then
                vim.lsp.enable(server)
              else
                vim.notify("Failed to install " .. package .. ". See :MasonLog", vim.log.levels.ERROR)
              end
            end))
          end
        end))
      end,
    })
  end
end
