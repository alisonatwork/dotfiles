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
	case "$PATH" in
		$HOME/bin:*|$HOME\\bin:*)
		;;
		*:$HOME/bin*|*:$HOME\\bin*)
			PATH="$HOME/bin:`echo $PATH | sed \"s|:$HOME[/\\]bin||g\"`"
		;;
		*)
			PATH="$HOME/bin:$PATH"
		;;
	esac
	export PATH
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
		TERM=cygwin
	;;
	MINGW*)
		TERM=xterm-256color
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

		for i in /usr/pkg/games/fortune /usr/games/fortune
		do
			if [ -x $i ]
			then
				$i
				break
			fi
		done
		unset i
	;;
	*)
	;;
esac

