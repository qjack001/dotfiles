function help --description 'Show this help documentation'

    set -l fish_documentation_link "https://fishshell.com/docs/current/commands.html"

    ## title block
    echo (set_color white)"▄▄▄▄▄▄▄"(set_color normal)
    echo (set_color black --background white)"|"(set_color cyan --background black)"     "(set_color black --background white)"|"(set_color normal) "    "(set_color cyan --bold --reverse)" Helpful Commands and Such "(set_color normal)
    echo (set_color black --background white)"|"(set_color cyan --background black)" ^ᵕ^ "(set_color black --background white)"|"(set_color normal)
    echo (set_color black --background white)"[ -==.]"(set_color normal)"──┐   You are using" (set_color magenta --bold)fish(set_color normal)!
    echo " "(set_color black --background white)"[=====]"(set_color normal)" "(set_color black --background white)"0"(set_color normal)"   "(set_color blue --underline)$fish_documentation_link(set_color normal)\n

    ## functions
    for function_name in (functions --names | string split ",")
        set -l function_details (functions --verbose --details $function_name)
        set -l function_filepath $function_details[1]
        set -l function_description $function_details[5]

        switch $function_filepath
        case "*/.config/fish/functions/*" # we only want the user-defined ones
            if string length --quiet $function_description
                echo $function_name (set_color brblack)$function_description(set_color normal)
            end
        end
    end

    echo \n 
end
