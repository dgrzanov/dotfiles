local handlers = require "user.lsp.handlers"
handlers.setup()
vim.lsp.config("*", { capabilities = handlers.capabilities, on_attach = handlers.on_attach })

-- Server definitions come from lspconfig; installation is explicit, outside Neovim.
-- Reuse an already-installed binary if it previously came from Mason.
local servers = {
  lua_ls = "lua-language-server",
  pyright = "pyright-langserver",
  ts_ls = "typescript-language-server",
  clangd = "clangd",
  bashls = "bash-language-server",
}
for server, executable in pairs(servers) do
  local command = vim.fn.exepath(executable)
  if command == "" then
    local existing = vim.fn.stdpath("data") .. "/mason/bin/" .. executable
    if vim.fn.executable(existing) == 1 then command = existing end
  end
  if command ~= "" then
    local config = vim.lsp.config[server]
    local cmd = vim.deepcopy(config.cmd)
    cmd[1] = command
    vim.lsp.config(server, { cmd = cmd })
    vim.lsp.enable(server)
  end
end
