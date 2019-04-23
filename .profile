EDITOR=vi
VISUAL=vi
export EDITOR VISUAL

if [ -x /usr/bin/more ]
then
	PAGER=more
else
	PAGER=less
	LESS="-X -R -F"
	export LESS
fi
export PAGER

if [ -z "$LANG" ]
then
	LANG="en_US.UTF-8"
	export LANG
fi

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

		if [ -x /usr/pkg/games/fortune ]
		then
			/usr/pkg/games/fortune
		elif [ -x /usr/games/fortune ]
		then
			/usr/games/fortune
		elif [ -f $HOME/tmp/fortunes -a -f $HOME/tmp/fortunes.count ]
		then
			awk 'BEGIN { srand(); x=int(rand() * '`cat $HOME/tmp/fortunes.count`') } /^%$/ { x--;next } x==0' $HOME/tmp/fortunes
		fi
	;;
	*)
	;;
esac

