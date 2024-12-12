#!/bin/sh

handle_termination() {
    echo "Terminating..."
    # Kill all child processes
    jobs -p | xargs -r kill
    exit 0
}

trap handle_termination INT TERM

# Check if at least one argument is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <dir1> <dir2> ..."
    exit 1
fi

# Iterate over all arguments
for dir in "$@"; do
    # Check if the directory exists
    if [ -d "$dir" ]; then
        # Run the command in the background
        (
            cd "$dir" &&
            if [ -x "meta/dev/dev" ]; then
                ./meta/dev/dev --no-caddy
            else
                echo "Error: meta/dev/dev not found or not executable in $dir"
            fi
        ) &
    else
        echo "Error: Directory $dir does not exist"
    fi
done

caddy run --config ./Caddyfile &

wait

