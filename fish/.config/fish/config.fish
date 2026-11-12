# PATH (ported from ~/.zprofile and ~/.zshenv)
/opt/homebrew/bin/brew shellenv | source
fish_add_path /Library/Frameworks/Python.framework/Versions/3.11/bin
fish_add_path $HOME/.cargo/bin
# fish_add_path ~/scripts

if status is-interactive
    set -g fish_greeting

    # map zoxide to cd
    zoxide init --cmd cd fish | source

    # prompt (LCARS theme in ~/.config/starship.toml)
    starship init fish | source

    # LCARS Classic syntax colors (palette: ~/lcars-colorscheme/palette/lcars.json)
    set -g fish_color_normal F4E7DA
    set -g fish_color_command EB943A
    set -g fish_color_keyword BAA4E5
    set -g fish_color_param F4E7DA
    set -g fish_color_option EA9C72
    set -g fish_color_quote FCC19F
    set -g fish_color_redirection BAA4E5
    set -g fish_color_end BAA4E5
    set -g fish_color_operator BAA4E5
    set -g fish_color_escape C082A9
    set -g fish_color_comment A08EA8
    set -g fish_color_error F08080
    set -g fish_color_valid_path --underline
    set -g fish_color_autosuggestion 7A506D
    set -g fish_color_selection --background=3B2D50
    set -g fish_color_search_match --background=3B2D50
    set -g fish_color_cancel F08080
    set -g fish_pager_color_progress 000000 --background=EB943A
    set -g fish_pager_color_prefix EB943A --bold
    set -g fish_pager_color_completion F4E7DA
    set -g fish_pager_color_description AE9FB6
    set -g fish_pager_color_selected_background --background=3B2D50
end
