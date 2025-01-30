#!/bin/bash

# Path to your Python script
PYTHON_SCRIPT="main.py"

# GitHub branch
BRANCH="main"

# Function to check if there are any commits made today
check_commits_today() {
    local today=$(date +"%Y-%m-%d")
    git log --since="$today 00:00:00" --until="$today 23:59:59" --oneline | wc -l
}

# Main loop: run continuously and check every 5 hours
while true; do
    # Check if there are any commits made today
    commits_today=$(check_commits_today)

    if [[ $commits_today -eq 0 ]]; then
        # Generate random number between 5 and 10
        runs=$((RANDOM % 6 + 5))

        echo "Running $PYTHON_SCRIPT $runs times..."
        
        # Run the script specified number of times
        for ((i = 1; i <= runs; i++)); do
            python "$PYTHON_SCRIPT"
            
            # Commit changes after each run
            git add .
            git commit -m "Auto commit $i of $runs on $(date +"%Y-%m-%d %H:%M:%S")"
            git push -u origin "$BRANCH"
        done
    else
        echo "Commits already exist for today. Skipping execution."

    # Wait for 5 hours before checking again
    echo "Sleeping for 5 hours..."
    sleep 5h
done