function new --wraps=mkdir --description 'Create a directory and cd into it'
    command mkdir -pv $argv
    cd $argv
end
