# Use fish for interactive terminals while keeping zsh available for scripts.
if [[ -o interactive && -x /opt/homebrew/bin/fish ]]; then
    if [[ -o login ]]; then
        exec /opt/homebrew/bin/fish --login
    else
        exec /opt/homebrew/bin/fish
    fi
fi
