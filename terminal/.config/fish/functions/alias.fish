function alias --wraps='abbr --add' --description 'Creates an expanding shorthand'
    set -l abbr_config "$HOME/dotfiles/terminal/.config/fish/conf.d/abbreviations.fish"
    abbr --add $argv &&
    abbr --show > $abbr_config &&
    source $abbr_config &&
    echo -- "Added abbreviation:" (set_color red --background white) "abbr -a" $argv (set_color normal)
    cat $abbr_config
end
