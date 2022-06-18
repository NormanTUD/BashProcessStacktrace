function get_parent_pid {
        parent_pid=$(ps -o ppid= $1 | sed -e 's/\s//g')
        parent_name=$(ps -p $parent_pid -o command | tr -d '\n' | sed -e 's/^COMMAND//' | sed -e "s/^/$parent_pid: /")
        echo $parent_name >&2
        echo $parent_pid
}

function process_callstack {
        pid=$$
        while [[ $pid -ne "1" ]]; do
                pid=$(get_parent_pid $pid)
        done
}

process_callstack
