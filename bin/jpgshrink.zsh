#! /bin/zsh

# jpgshrink — shrink an image multiple times till below max size threshold

j=${1?Must provide jpg}
max=${2?Must provide max size in bytes}

qpct=40
sz=$( stat -c '%s' $j )
max+=000

if (( sz < max )); then
  print "Copying since $sz already small enough."
  cp $j out/j
else
  print -n $sz
  while (( sz > max )); do
    #print "Shrinking $j"
    print -n .
    convert -resize '700x700!' -strip -interlace Plane -gaussian-blur 0.05 -quality $qpct% $j out/$j
    (( qpct-=10 ))
    sz=$( stat -c '%s' out/$j )
    #print $sz
    if (( qpct < 10 )); then
      print -n maxed out
      break
    fi
  done
  print $sz
fi
