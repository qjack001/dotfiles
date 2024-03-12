function fish_prompt

    switch $status
        case 0
            set arrow (set_color green)'→'
        case '*'
            set arrow (set_color red)'→'
    end

    set -l git_repo (command git --no-optional-locks rev-parse --show-toplevel 2>/dev/null || echo)

    if test -n $git_repo
        
        set -l path_to_git_parent (command git --no-optional-locks rev-parse --show-cdup 2>/dev/null)
        set -l distance_to_git (math (string match -ar '/' $path_to_git_parent | count) + 1)

        set current_dir (prompt_pwd -d 0 | string split --right --max $distance_to_git '/')
        set --erase current_dir[1]
        
    else
        set current_dir (prompt_pwd -d 0 | string split '/')
    end

    set current_dir[-1] (set_color normal --dim)$current_dir[-1]
    
    set_color brblack
    echo (string join '/' $current_dir) $arrow (set_color normal)
end
