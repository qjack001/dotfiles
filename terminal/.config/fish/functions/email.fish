function email

    set -l folder $argv[1]
    set -l json_data (himalaya envelope list --output json --folder $folder order by date desc 2>/dev/null)
        # not flag seen
    set -l ids (echo $json_data | jq -r '.[].id')
    set -l subjects (echo $json_data | jq -r '.[].subject')
    set -l senders (echo $json_data | jq -r '.[] | .from.name')
    
     set -l flags (echo $json_data | jq -r '.[] | .flags | contains(["Seen"])')

    printf "\n"
    
    for i in (seq (count $ids))
        printf "%s\t%s  %s\n" \
            (set_color green)$ids[$i](set_color normal) \
            (test "$flags[$i]" = "true"; and set_color normal; or set_color --bold)$subjects[$i](set_color normal) \
            (set_color blue)"@$senders[$i]"(set_color normal)
    end

    printf "\n"
    read -P "READ:   " message_id
    if test -n "$message_id"
        himalaya messages read --folder $folder $message_id 2>/dev/null |
            sed 's/\[ \(https[^]]*\) \]/[(link)](\1")/g'| glow --pager
            #sed '/^$/d; s/^/<p>/; s/$/<\/p>/' |
            #w3m -T text/html
    end
end
