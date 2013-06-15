#! /bin/zsh

# Example showing absolute paths of running script.
#
# Node: __dirname and __filename
# Ruby: __FILE__
# Python: __file__

print $PWD
pwd -P
print $0:h

__dirname__=$(cd -P $0:h && pwd -P)
__file__=$__dirname__/$0:t

print $__dirname__
print $__file__
