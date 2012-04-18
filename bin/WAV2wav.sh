#! /bin/bash

out=out$$.wav
sox $1 -s $out
vlc $out
