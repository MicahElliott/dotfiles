#! /bin/zsh

# Silly target used by uzbl refresher.

pipe=${TMPDIR-/tmp}/refresher.fifo
#pipe="${1?Must provide pipe}"

echo "waiting for octo…"
sleep 10
echo "browserctl: reloading"
#echo 'uri yahoo.com' > $pipe
echo 'reload' > $pipe
