local lint = require "lint"
-- Ruff requires a filename even when checking an unsaved scratch buffer.
lint.linters.ruff.args[5] = function()
  local name = vim.api.nvim_buf_get_name(0)
  return name ~= "" and name or (vim.fn.getcwd() .. "/untitled.py")
end
-- Run only on request, never on startup/save. Extend this table for other languages.
lint.linters_by_ft = {
  python = { "ruff" },
  javascript = { "eslint_d" }, javascriptreact = { "eslint_d" },
  typescript = { "eslint_d" }, typescriptreact = { "eslint_d" },
  sh = { "shellcheck" }, bash = { "shellcheck" },
  lua = { "luacheck" },
}

local function run()
  local names = lint.linters_by_ft[vim.bo.filetype]
  if not names then
    vim.notify("No linter configured for " .. vim.bo.filetype, vim.log.levels.INFO)
    return
  end
  local root = vim.fs.root(0, { "pyproject.toml", "package.json", ".git" }) or vim.fn.getcwd()
  for _, name in ipairs(names) do
    local command = name
    local candidates = { root .. "/.venv/bin/" .. name, root .. "/node_modules/.bin/" .. name }
    for _, candidate in ipairs(candidates) do
      if vim.fn.executable(candidate) == 1 then command = candidate; break end
    end
    if vim.fn.executable(command) ~= 1 then
      vim.notify("Missing " .. name .. "; install it in the project environment or on PATH", vim.log.levels.WARN)
      return
    end
    lint.linters[name].cmd = command
  end
  lint.try_lint(names, { cwd = root })
end
vim.keymap.set("n", "<leader>cl", run, { desc = "Lint current buffer" })
vim.api.nvim_create_user_command("Lint", run, { desc = "Run filetype linters" })
