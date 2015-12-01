#! /bin/bash 

awk '/SYNOPSIS/{p=1;print;next} p&&/KEY BINDINGS/{p=0};p' README.md |
	sed -e '1,3 d' -e 's/^/"/' -e 's/$/\\n"/'
