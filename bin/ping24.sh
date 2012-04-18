#! /bin/bash

# Ex: ping24 google.com
# Ex: ping24 192.168.1.105

# Failed pings may stall the minute cycle, so expect this to take
# longer than 24 hours if there are failures.

tgt=${1?'Must provide target'}

echo "First ping test must pass..."
# or something is probably wrong.
ping -c1 $tgt \
    && echo -e "\nok, proceeding with 24 hour ping cycle\n" \
    || { echo "fail, check setup "; exit 1; }

for i in {1..1440}; do
    ping -c1 $tgt &>/dev/null && echo -n "ok -- " || echo -n "fail -- " 
    date "+%k:%M"
    sleep 60
done
