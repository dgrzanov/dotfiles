-- :help options
vim.opt.number = true
vim.opt.relativenumber = true 

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.scrolloff = 7
vim.opt.mouse = "a"

vim.opt.termguicolors = true
vim.opt.showmode = false -- lualine displays the current mode.

vim.opt.updatetime = 50

-- which-key displays pending mappings after a short pause.
vim.opt.timeoutlen = 500

--vim.opt.autochdir = true

-- Pick up external saves even while a window stays focused and idle.
vim.opt.autoread = true
if vim.g.external_edit_timer then
  vim.fn.timer_stop(vim.g.external_edit_timer)
end
vim.g.external_edit_timer = vim.fn.timer_start(250, function()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "" and not vim.bo[buf].modified then
      vim.cmd.checktime(buf)
    end
  end
end, { ["repeat"] = -1 })
