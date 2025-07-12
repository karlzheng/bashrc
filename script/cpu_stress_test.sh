#!/bin/bash

# CPU Stress Test Script
# Creates multiple subprocesses to perform infinite loop calculations, increasing CPU usage

# Check if a parameter is provided; if not, default to 10 times the number of CPU cores
if [ -z "$1" ]; then
    # Get the number of CPU cores
    CORES=$(sysctl -n hw.ncpu)
    THREADS=$((CORES * 10))
else
    THREADS=$1
fi

echo "Will use $THREADS threads for stress testing"
echo "Press Ctrl+C to stop the test"

# Define the stress test function
stress_cpu() {
    while true; do
        # Perform intensive calculations
        echo "scale=5000; 4*a(1)" | bc -lq > /dev/null 2>&1
    done
}

# Create subprocesses for stress testing
pids=()
for ((i=1; i<=$THREADS; i++)); do
    stress_cpu &
    pids+=($!)
done

# Handle user interruption
trap "echo 'Stopping stress test'; kill ${pids[*]}; exit" SIGINT SIGTERM

# Keep the main script running
wait
