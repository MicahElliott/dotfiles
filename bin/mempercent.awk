#! /usr/bin/gawk -f

# mempercent — print the percentage of used memory
#
# Can be called by an i3status command (such as my-i3status).
# See i3status(1).
#
# Now an awk script and 3x speed of equivalent shell scipt

# hack: http://ubuntuforums.org/showthread.php?t=1290290&page=2
# argc would be 1
# more info: http://backreference.org/2013/10/22/argument-juggling-with-awk/
BEGIN { ARGV[1] = "/proc/meminfo"; ARGC = 2 }

# Available reflects the larger/realistic amount, vs MemFree
/MemAvailable/ { avail = $2 }
/MemTotal/     { tot   = $2 }

#END {
  #ans = (tot - avail) / tot * 100
  #OFMT = "%0.0f%%"
  #print ans
#}
END { printf "%0.0f%%\n", (tot - avail) / tot * 100 }
