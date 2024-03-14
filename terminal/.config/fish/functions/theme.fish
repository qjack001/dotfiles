function theme --description 'Set the colors of the terminal'

    set -l config_dir "$HOME/dotfiles/terminal/.config/alacritty"
    set -l selected_theme_location "$config_dir/selected-theme.toml"

    set -l app_path "/Applications/Alacritty.app"
    set -l icon_path "$app_path/Contents/Resources/alacritty.icns"

    switch $argv[1]
        case 'light'
            set theme 'light-theme.toml'
            set icon 'light.icns'
        case 'dark'
            set theme 'dark-theme.toml'
            set icon 'dark.icns'
        case '*'
            echo Unsupported theme: (set_color red --bold)$argv[1](set_color normal)
            echo Availible themes are (set_color cyan)light(set_color normal) or (set_color cyan)dark(set_color normal).
            return 1
    end

    cp "$config_dir/$theme" $selected_theme_location
    touch "$config_dir/alacritty.toml" # force re-evaluation of settings

    set -l new_icon "$config_dir/icon/$icon"
    cp $new_icon $icon_path
    touch $app_path
    killall Dock # force refresh of icon
end
