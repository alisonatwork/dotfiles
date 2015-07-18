EDITOR=vi
VISUAL=vi
export EDITOR VISUAL

if [ -x /usr/bin/more ]
then
    PAGER=more
else
    PAGER=less
fi
export PAGER

if [ -d "$HOME/bin" ]
then
	if ! echo "$PATH" | egrep -q "^$HOME[/\\]bin"
	then
        PATH="$HOME/bin:`echo $PATH | sed \"s|:$HOME[/\\]bin||g\"`"
        export PATH
	fi
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

case "`uname 2> /dev/null`" in
	windows32)
		TERM=Cygwin
	;;
	*)
		TERM=xterm
	;;
esac
export TERM

case "`hostname 2> /dev/null`" in
	sdf)
		MAIL=/mail/${LOGNAME:?}
		export MAIL
	;;
	*)
	;;
esac

case "$-" in
	*i*)
		PS1='$ '
		PS2='> '
		PS3='#? '
		PS4='+ '
		export PS1 PS2 PS3 PS4

		FORTUNES="/usr/pkg/games/fortune /usr/games/fortune"
		for i in `echo $FORTUNES`
		do
			if [ -x $i ]
			then
				$i
				break
			fi
		done
		unset i FORTUNES
	;;
	*)
	;;
esac

