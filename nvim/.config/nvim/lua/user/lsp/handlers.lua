local M = {}
function M.setup()
  vim.diagnostic.config({
    virtual_text = false, underline = true, severity_sort = true, update_in_insert = true,
    signs = { text = {
      [vim.diagnostic.severity.ERROR] = "", [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "", [vim.diagnostic.severity.INFO] = "",
    } },
    float = { border = "rounded", source = "always" },
  })
  vim.api.nvim_create_user_command("Format", function() vim.lsp.buf.format({ async = true }) end, {})
end
function M.on_attach(client, bufnr)
  local function map(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end
  map("gD", vim.lsp.buf.declaration, "Go to declaration")
  map("gd", vim.lsp.buf.definition, "Go to definition")
  map("K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover documentation")
  map("gi", vim.lsp.buf.implementation, "Go to implementation")
  map("gr", vim.lsp.buf.references, "Find references")
  map("<leader>ck", vim.lsp.buf.signature_help, "Signature help")
  map("<leader>cn", vim.lsp.buf.rename, "Rename symbol")
  map("<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
  map("gl", vim.diagnostic.open_float, "Show diagnostic")
  if client:supports_method("textDocument/documentHighlight") then
    local group = vim.api.nvim_create_augroup("UserLspHighlight" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", { group = group, buffer = bufnr, callback = vim.lsp.buf.document_highlight })
    vim.api.nvim_create_autocmd("CursorMoved", { group = group, buffer = bufnr, callback = vim.lsp.buf.clear_references })
  end
end
M.capabilities = require("cmp_nvim_lsp").default_capabilities()
return M
