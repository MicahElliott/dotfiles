#! /bin/zsh

# grepngx — glue together utils that gather/parse/grep nginx logs

# pat=karen_blake
# pat=759164
# pat='23\.31\.83\.81'
pat=${1?provide search pattern}
# log=access.log-20161201.gz
# log=access.log
log=${2?provide log file path end}

telegrep.zsh $pat /opt/resty/nginx/logs/$log |
    sort |log2tsv.zsh |cut -f1-4,6,9 |grep $pat |user-agent.rb
