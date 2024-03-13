function func --wraps='funced --save' --description 'Create and edit fish functions'

    set -l function_name $argv[1]
    set -l fish_dir ".config/fish/functions"
    set -l stow_dir "dotfiles"
    set -l stow_package "terminal"

    funced --save $argv || exit

    if test ! -L "$HOME/$fish_dir/$function_name.fish"
        if test -e "$HOME/$fish_dir/$function_name.fish"
            # function file exists, but is not a stow-managed symlink

            mv -f "$HOME/$fish_dir/$function_name.fish" "$HOME/$stow_dir/$stow_package/$fish_dir/$function_name.fish"
            stow --dir="$HOME/$stow_dir" --stow $stow_package
            
            echo "Moved $function_name.fish to ~/$stow_dir/$stow_package/$fish_dir/"
        else
            echo (set_color red)"No file '$function_name.fish' found in ~/$fish_dir/"(set_color normal)
            echo "will not move to stow-managed repo."
        end
    else
        # already a symlink; changes should be picked-up by stow automatically
        echo "Saved $function_name.fish to stow-ed dotfiles"
    end
end
