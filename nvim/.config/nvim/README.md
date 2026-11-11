# Neovim configuration

Requires Neovim 0.11+ and Git. Leader is Space.

## Stable plugin management

lazy.nvim replaces packer. Existing plugin revisions were preserved in
`lazy-lock.json`; new plugins are locked too. Startup update checks, automatic
plugin installs, config reloads, and automatic parser installs are disabled.
Old packer packages are not loaded (lazy resets `packpath`).

- Fresh checkout: run `:lua require("lazy").install({ lockfile = true })`, then
  restart Neovim. This installs the recorded revisions instead of newest commits.
- Explicit update: `:Lazy update`. Review the lockfile diff before committing.
- Restore recorded versions: `:Lazy restore`.
- Parsers: `:TSInstallSync javascript typescript python c`; update deliberately
  with `:TSUpdate`. The existing Treesitter master API is retained.
- Plugins live in `~/.local/share/nvim/lazy-user`, separate from older LazyVim
  installations. The lazy.nvim bootstrap itself lives in `lazy/lazy.nvim`.

## Keybindings

| Key | Action |
| --- | --- |
| Space, then pause | which-key suggestions |
| Space ? | Show buffer keybindings |
| Space e | Toggle nvim-tree (`?` inside it shows help) |
| Space gg | Floating LazyGit at the current file's Git root; `Esc` or `q` exits |
| Space / | Comment current line or visual selection |
| Space cl / `:Lint` | Run filetype linters on demand |
| Space ch / `gl` | Diagnostic details |
| Space q | Diagnostics location list |
| Space f / Ctrl-p | Find files / Git files |
| Space s | Search project text (requires ripgrep) |
| Space cr | Replace word throughout file |
| Space ca / cn / cf / ck | LSP action / rename / format / signature |
| Space bl | Git blame current line |

Ctrl-k remains window-up. Tab / Shift-Tab navigate completion or native snippet
placeholders. Smear-cursor is enabled for normal-mode movement.

## Commenting

Select lines with `V` and movement, then press **Space followed by /** to toggle
comments. In normal mode, the same binding toggles the current line. No terminal
configuration is needed. Native `gc`/`gcc` also work.

## Linters and language servers

Linters run only through Space cl or `:Lint`, never automatically. Python uses
Ruff (installed with `uv tool install ruff`); JS/TS uses eslint_d, shell uses
shellcheck, and Lua uses luacheck. Install those tools explicitly when needed.
Project `.venv/bin` and `node_modules/.bin` binaries take precedence over PATH.
Diagnostics use Neovim's native UI. Ruff checks the current unsaved buffer and
respects project configuration; this binding does not apply fixes.

Mason and LuaSnip have been replaced as requested. Snippet expansion and jumping
use `vim.snippet` via nvim-cmp; LuaSnip-specific snippet collections are not loaded.
`nvim-lspconfig` remains for its server definitions, with native
`vim.lsp.config` / `vim.lsp.enable` configuring and enabling servers.

Install desired servers explicitly and restart Neovim:

- Python: `uv tool install pyright`
- Lua: `brew install lua-language-server`
- JS/TS: `npm install -g typescript typescript-language-server`
- Bash: `npm install -g bash-language-server`
- C/C++: clangd on PATH

Only available servers are enabled. Previously installed binaries under
`~/.local/share/nvim/mason/bin` are reused as a migration fallback, without loading
Mason or updating those tools. Server configuration lives in `lua/user/lsp/init.lua`;
linter selection lives in `lua/user/lint.lua`.

## Other native alternatives (retained by choice)

- nvim-cmp/sources: native LSP completion, buffer keyword completion, path completion.
- hardline: native `statusline` (custom formatting needed).
- Telescope: `:find`, `:grep`, quickfix (no equivalent picker UI).
- nvim-treesitter: native highlighting with manually managed parser binaries/queries.
- lspconfig: define server commands/root markers directly with `vim.lsp.config`.
- Gitsigns: native diff mode covers comparisons, but not inline Git signs/blame.

There is no comparable native automatic-pairing or animated-cursor feature.
Harpoon is removed; native marks and the jumplist remain available.
