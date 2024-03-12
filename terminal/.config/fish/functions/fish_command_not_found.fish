function fish_command_not_found
    echo "Unknown command:" (set_color red --bold)(string escape -- $argv[1])(set_color normal)
end
