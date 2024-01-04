#!/bin/bash



# Function to launch a process in the background

launch_process() {

  command="$1"

  logfile="$2"



  # Launch the process in the background and redirect stdout and stderr to the specified logfile

  $command >> "$logfile" 2>> "$logfile" &

  pid=$!



  # Store the process ID in an array

  pids+=("$pid")

}

# Function to send a signal to all background processes

send_signal_to_processes() {

  signal="$1"

  for pid in "${pids[@]}"; do

    kill "$signal" "$pid"

  done

}

# Launch multiple processes in the background

launch_process "bash /home/anvar/loop1.sh" "/tmp/stdout.log" "/tmp/stderr.log"

launch_process "bash /home/anvar/loop2.sh" "/tmp/stdout.log" "/tmp/stderr.log"

launch_process "bash /home/anvar/usage.sh" "/tmp/stdout.log" "/tmp/stderr.log"

# Wait for user input

read -p "Press Enter to send SIGINT to all processes..."

# Send SIGINT signal to all background processes

send_signal_to_processes SIGINT

# Wait for user input

read -p "Press Enter to send SIGTERM to all processes..."

# Send SIGTERM signal to all background processes

send_signal_to_processes SIGTERM

echo "All signals sent to processes."

