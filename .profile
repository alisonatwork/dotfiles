EDITOR=vi
VISUAL=vi
export EDITOR VISUAL

if [ -x `command -v less` ]
then
	PAGER=less
	LESS="-X -R -F"
	export LESS
else
	PAGER=more
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
	MINGW*|Darwin)
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

		if [ -x "`command -v fortune`" ]
		then
			`command -v fortune`
		elif [ -f "$HOME/tmp/fortunes" -a -f "$HOME/tmp/fortunes.count" ]
		then
			awk 'BEGIN { srand(); x=int(rand() * '`cat "$HOME/tmp/fortunes.count"`') } /^%$/ { x--;next } x==0' "$HOME/tmp/fortunes"
		fi
	;;
	*)
	;;
esac

