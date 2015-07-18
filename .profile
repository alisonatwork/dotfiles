EDITOR=vi
VISUAL=vi
PAGER=more
export EDITOR VISUAL PAGER

TERM=xterm
export TERM

if [ -d "$HOME/bin" ]
then
	if ! echo "$PATH" | egrep -q "$HOME[/\\]bin"
	then
		PATH="$PATH:$HOME/bin"
	fi
fi

if [ "`hostname 2> /dev/null`" = "sdf" ]
then
	MAIL=/mail/${LOGNAME:?}
	export MAIL
fi

if [ -f "$HOME/.signature" ]
then
	sign=`cat "$HOME/.signature"`
	export sign
fi

if [ -f "$HOME/.shrc" ]
then
	ENV="$HOME/.shrc"
	export ENV
fi

FORTUNES="/usr/pkg/games/fortune /usr/games/fortune"
for i in `echo $FORTUNES`
do
	if [ -x $i ]
	then
		$i
		break
	fi
done
unset FORTUNES

