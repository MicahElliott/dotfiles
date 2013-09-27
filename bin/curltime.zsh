#! /bin/zsh

# curltime — run curl with various timings

url=${1?Must provide url}

fmt="

namelookup:    %{time_namelookup}
connect:       %{time_connect}
appconnect:    %{time_appconnect}
pretransfer:   %{time_pretransfer}
redirect:      %{time_redirect}
starttransfer: %{time_starttransfer}
               -----
total:         %{time_total}
"

curl -s -v -w $fmt $@ $url
