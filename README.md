# dotfiles

GNU Stow is being used for managing dotfiles.

## Prerequisites

These configs target macOS with [Homebrew](https://brew.sh) installed at `/opt/homebrew`
(Apple Silicon). Several configs hard-code paths under `/opt/homebrew`.

### Core

| Tool | Needed for | Install |
| --- | --- | --- |
| [Homebrew](https://brew.sh) | Installing everything else; `brew shellenv` in fish, `brew --prefix` in zsh | see brew.sh |
| [GNU Stow](https://www.gnu.org/software/stow/) | Symlinking the configs | `brew install stow` |
| Git | Cloning this repo, lazy.nvim bootstrap | `xcode-select --install` or `brew install git` |

### Fonts

| Font | Needed for | Install |
| --- | --- | --- |
| Iosevka Term | Primary Ghostty font | `brew install --cask font-iosevka` |
| MesloLGS NF (Nerd Font) | Ghostty fallback, icons and Powerline glyphs in tmux, Neovim statusline, nvim-tree | `brew install --cask font-meslo-lg-nerd-font` |

### LCARS colorscheme

The fish, tmux and Ghostty configs load generated theme files from
`~/lcars-colorscheme`, and Neovim uses the `dgrzanov/lcars.nvim` plugin.
Clone and build the colorscheme (requires Node.js / npm):

```zsh
git clone https://github.com/dgrzanov/lcars-colorscheme.git ~/lcars-colorscheme
cd ~/lcars-colorscheme && npm install && npm run build
```

### Per application

| Package | Requires |
| --- | --- |
| `fish` | [fish](https://fishshell.com) (`brew install fish`), [starship](https://starship.rs) (`brew install starship`), [zoxide](https://github.com/ajeetdsouza/zoxide) (`brew install zoxide`), LCARS colorscheme (for the prompt palette). Optional: Rust/Cargo (`~/.cargo/bin` is added to PATH), Python 3.11 from python.org (its framework `bin` is added to PATH) |
| `zsh` | [Powerlevel10k](https://github.com/romkatv/powerlevel10k) via Homebrew (`brew install powerlevel10k`), zoxide (`brew install zoxide`) |
| `starship` | starship (`brew install starship`), a Nerd Font |
| `ghostty` | [Ghostty](https://ghostty.org) (`brew install --cask ghostty`), fish at `/opt/homebrew/bin/fish`, Iosevka Term + MesloLGS NF, LCARS colorscheme |
| `alacritty` | [Alacritty](https://alacritty.org) (`brew install --cask alacritty`), [alacritty-theme](https://github.com/alacritty/alacritty-theme) cloned into `~/.config/alacritty/themes` |
| `tmux` | [tmux](https://github.com/tmux/tmux) (`brew install tmux`), fish at `/opt/homebrew/bin/fish` (default shell), a Nerd Font, LCARS colorscheme, `xclip` for copy-mode yank |
| `tmuxinator` | [tmuxinator](https://github.com/tmuxinator/tmuxinator) (`brew install tmuxinator`), tmux |
| `nvim` | See below |

### Neovim

Full details are in [nvim/.config/nvim/README.md](nvim/.config/nvim/README.md).

- **Required:** Neovim 0.12+ (nvim-treesitter is on its `main` branch), Git, a Nerd Font
- **Treesitter:** [`tree-sitter` CLI](https://github.com/tree-sitter/tree-sitter) and a C compiler for building parsers (`brew install tree-sitter-cli`)
- **Search:** [ripgrep](https://github.com/BurntSushi/ripgrep) for `Space s` live grep (`brew install ripgrep`)
- **Git UI:** [lazygit](https://github.com/jesseduffield/lazygit) for `Space gg` (`brew install lazygit`)
- **Language servers** (optional, enabled only if found on PATH):
  - Python: `uv tool install pyright`
  - Lua: `brew install lua-language-server`
  - JS/TS: `npm install -g typescript typescript-language-server`
  - Bash: `npm install -g bash-language-server`
  - C/C++: `clangd` (ships with Xcode Command Line Tools)
- **Linters** (optional, run on demand with `Space cl`):
  - Python: `uv tool install ruff`
  - JS/TS: `npm install -g eslint_d`
  - Shell: `brew install shellcheck`
  - Lua: `luarocks install luacheck`

`uv` (`brew install uv`) and Node.js/npm (`brew install node`) are needed for the
tools installed through them.

### Quick install

Everything required (not the optional LSPs/linters) in one go:

```zsh
brew install stow git fish starship zoxide powerlevel10k tmux tmuxinator \
  neovim tree-sitter-cli ripgrep lazygit node xclip
brew install --cask ghostty alacritty font-iosevka font-meslo-lg-nerd-font
```

## Installation

If you want to install my config for specific application, just type:

```zsh
stow [application]
```

For example, you want to install the neovim config:

```zsh
stow nvim
```

Stow will create a symlink in the location the config is supposed to be to the config located in this repository.
