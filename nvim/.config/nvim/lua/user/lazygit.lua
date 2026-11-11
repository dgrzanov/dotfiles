local M = {}
local win, buf

local function geometry()
  local width = math.max(1, math.floor(vim.o.columns * 0.9))
  local height = math.max(1, math.floor((vim.o.lines - vim.o.cmdheight - 2) * 0.9))
  return { relative = "editor", width = width, height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.max(0, math.floor((vim.o.lines - height) / 2) - 1),
    style = "minimal", border = "rounded", title = " LazyGit ", title_pos = "center" }
end

function M.open()
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_set_current_win(win)
    vim.cmd.startinsert()
    return
  end
  if vim.fn.executable("lazygit") ~= 1 then
    vim.notify("Install lazygit and make it available on PATH", vim.log.levels.ERROR)
    return
  end
  local current = vim.api.nvim_buf_get_name(0)
  local start = current ~= "" and vim.fn.fnamemodify(current, ":h") or vim.fn.getcwd()
  local root = vim.fs.root(start, ".git") or vim.fn.getcwd()
  buf = vim.api.nvim_create_buf(false, true)
  local terminal_buf = buf
  local closed_by_user = false
  win = vim.api.nvim_open_win(buf, true, geometry())
  vim.bo[buf].bufhidden = "wipe"
  local job = vim.fn.jobstart({ "lazygit" }, {
    term = true, cwd = root,
    on_exit = function(_, code)
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(terminal_buf) then
          vim.api.nvim_buf_delete(terminal_buf, { force = true })
        end
        if buf == terminal_buf then win, buf = nil, nil end
        if code ~= 0 and not closed_by_user then
          vim.notify("LazyGit exited with code " .. code, vim.log.levels.WARN)
        end
        vim.cmd.checktime()
      end)
    end,
  })
  if job <= 0 then
    vim.api.nvim_buf_delete(buf, { force = true })
    win, buf = nil, nil
    vim.notify("Could not start lazygit", vim.log.levels.ERROR)
    return
  end
  vim.keymap.set({ "t", "n" }, "<Esc>", function()
    closed_by_user = true
    vim.cmd.stopinsert()
    if vim.api.nvim_buf_is_valid(terminal_buf) then
      vim.api.nvim_buf_delete(terminal_buf, { force = true })
    end
  end, { buffer = terminal_buf, silent = true, desc = "Close LazyGit" })
  vim.cmd.startinsert()
end

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("UserLazyGit", { clear = true }),
  callback = function()
    if win and vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_set_config(win, geometry()) end
  end,
})
return M
