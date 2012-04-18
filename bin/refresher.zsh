#! /bin/zsh

# Instrument uzbl to auto-refresh on filesystem changes.

url="${1?Must provide url to view}"
filere="${2?Must provide file regex to watch}"
pipe=${TMPDIR-/tmp}/refresher.fifo
#geom=640x480 
geom=800x800

cleanup() {
    echo "Killing jobs"
    kill %2
    kill %1
    echo "Deleting fifo"
    rm $pipe
    echo "\n\nNow manually:"
    echo "  fg; ^C"
}

trap 'cleanup' INT

# For some reason this won't work from script.
#echo "Creating pipe $pipe and keeping it open."
#mkfifo $pipe
#cat > $pipe &
if [[ ! -p "$pipe" ]]; then
    echo "You first need to run this yourself:"
    echo "  mkfifo $pipe && cat > $pipe &"
    exit
fi
echo "I hope you’ve already run ‘cat > $pipe &’\n"
sleep 3

echo "Firing Uzbl on $url"
uzbl-browser "$url" -g $geom -c - < $pipe &

echo "Watching $PWD; interrupt to end"
# This just does not work.
#dnotify -a . -e 'echo reload > $pipe'
#dnotify -q 1 -M $dir -e "${0:h}/browserctl.zsh"
# This is going to be much better with pyinotify (or maybe watchr) to
# watch individual files.
#watchr "$filere" -e "${0:h}/browserctl.zsh"
watchr "${0:h}/browserctl.rb"

#sleep 60
