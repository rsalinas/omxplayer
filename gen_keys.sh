#! /bin/bash -eu 

awk '/KEY BINDINGS/{p=1;print;next} p&&/KEY CONFIG/{p=0};p' README.md |
	sed -e '1,3 d' -e 's/^/"/' -e 's/$/\\n"/'
