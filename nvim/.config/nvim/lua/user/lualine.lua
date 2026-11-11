local function wide()
  return vim.fn.winwidth(0) >= 100
end

local prose = { "asciidoc", "help", "mail", "markdown", "nroff", "org", "pandoc", "plaintex", "rst", "tex", "text" }
local function wordcount()
  if not vim.tbl_contains(prose, vim.bo.filetype) or vim.fn.line("$") > 5000 then return "" end
  local count = vim.fn.wordcount()
  return (count.visual_words or count.words) .. " words"
end

local function whitespace()
  if vim.bo.readonly or not vim.bo.modifiable or vim.bo.buftype ~= "" or vim.fn.line("$") > 5000 then
    return ""
  end
  local warnings = {}
  local function check(label, pattern)
    local line = vim.fn.search(pattern, "nw")
    if line > 0 then warnings[#warnings + 1] = label .. ":" .. line end
  end
  if vim.bo.filetype ~= "markdown" then check("trailing", [[\s$]]) end
  check("mixed indent", [[\v(^\t* +\t\s*\S)|(^\t+ {]] .. vim.bo.tabstop .. [[,}\S)]])
  local spaces = vim.fn.search([[^ \+\S]], "nw")
  local tabs = vim.fn.search([[^\t\+\S]], "nw")
  if spaces > 0 and tabs > 0 then warnings[#warnings + 1] = "mixed file indent" end
  check("conflict", [[^\(<\{7} \|>\{7} \)]])
  return table.concat(warnings, " ")
end

-- LCARS panels: square screen edges, rounded inner ends, and a black center gap.
local colors = require("lcars").palette()
local theme = vim.deepcopy(require("lualine.themes.lcars"))
for mode, sections in pairs(theme) do
  sections.b = { fg = colors.black, bg = mode == "inactive" and colors.comment or colors.almond_creme }
  sections.c = { fg = colors.muted, bg = colors.black }
  sections.x = { fg = colors.muted, bg = colors.black }
  sections.y = { fg = colors.black, bg = colors.african_violet }
  sections.z = vim.deepcopy(sections.a)
end

require("lualine").setup({
  options = {
    theme = theme,
    globalstatus = true,
    component_separators = "",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { { "mode", separator = { left = "", right = "" }, padding = 1 } },
    lualine_b = { { "branch", cond = wide }, { "filename", padding = 2 } },
    lualine_c = {},
    lualine_x = {
      { wordcount, cond = wide },
      { "diagnostics", sources = { "nvim_diagnostic" }, sections = { "error", "warn" } },
      { whitespace, color = { fg = colors.barley } },
    },
    lualine_y = {
      { "filetype", fmt = string.upper, cond = function() return vim.fn.winwidth(0) >= 60 end },
    },
    lualine_z = { { "location", separator = { left = "", right = "" }, padding = 1 } },
  },
  extensions = { "nvim-tree", "quickfix", "lazy" },
})
