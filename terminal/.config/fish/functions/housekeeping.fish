function housekeeping --description 'Do cleanup chores for brew installs'
    set -l brewfile ~/dotfiles/Brewfile
    brew update &&
    brew upgrade &&
    brew cleanup &&
    brew autoremove &&
    brew bundle dump --file=$brewfile --force --describe &&
    brew bundle install --file=$brewfile &&
    fish_update_completions
end
