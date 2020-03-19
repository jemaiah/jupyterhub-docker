#!/bin/bash
set -eo pipefail
shopt -s nullglob

wantHelp=
for arg; do
	case "$arg" in
		-'?'|--help|--print-defaults|-V|--version)
			wantHelp=1
			break
			;;
	esac
done

echo "jupyterhub password : `cat /home/jupyterhub/.passwd`"
### install jupyterhub python 2 kernel
/home/jupyterhub/anaconda2/bin/ipython kernel install --name python2

$@

