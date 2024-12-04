#!/bin/bash

# January 1, 2024 00:00:00 UTC in epoch time
START_OF_2024=1704067200

echo "🎵 Your CLI Wrapped 2024 🎵"
echo "============================="

echo -e "\nYour Most Used Commands in 2024:"
echo "==================="

# Process zsh history with timestamp filtering
cat ~/.zsh_history | \
    awk -v start=$START_OF_2024 -F":" '{
        if ($2 >= start) {
            sub(/^: [0-9]*:[0-9]*;/, "");
            print
        }
    }' | \
    awk '{print $1}' | \
    sort | \
    uniq -c | \
    sort -rn | \
    head -n 10 | \
    awk '{command=$2; count=$1; printf "%2d. %-20s %d times\n", NR, command, count}'

# Calculate total 2024 commands
total_commands=$(cat ~/.zsh_history | \
    awk -v start=$START_OF_2024 -F":" '{
        if ($2 >= start) {
            print
        }
    }' | wc -l)

echo -e "\nTotal commands in 2024: $total_commands"

# Add date range context
current_date=$(date "+%B %d, %Y")
echo "Period: January 01, 2024 - $current_date"
