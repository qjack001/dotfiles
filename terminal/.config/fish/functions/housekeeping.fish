function housekeeping --description 'Do cleanup chores for brew installs'
    brew update &&
    brew upgrade &&
    brew cleanup &&
    brew autoremove
end
