if [ -z "$HOME" ]
then
	if [ -z "$USERPROFILE" ]
	then
		echo "Can't find HOME" 1>&2
		return
	fi
	export HOME="$USERPROFILE"
fi

shopt -q login_shell && cd "$HOME"

if [ ! -f "$HOME/.profile" ]
then
	echo "Can't find .profile" 1>&2
	return
fi

source "$HOME/.profile"

case "$-" in
	*i*)
		if [ ! -f "$ENV" ]
		then
			echo "Can't find ${ENV:-ENV}" 1>&2
			return
		fi
		source "$ENV"
	;;
esac
