if [ -z "$HOME" ]
then
	if [ -z "$USERPROFILE" ]
	then
		echo "Can't find HOME" 1>&2
	else
		export HOME="$USERPROFILE"
	fi
fi

if [ -n "$HOME" ]
then
	if [ "$HOME" != "$PWD" ]
	then
		cd "$HOME"
	fi
	if [ -f "$HOME/.profile" ]
	then
		source "$HOME/.profile"
	else
		echo "Can't find .profile" 1>&2
	fi
	case "$-" in
		*i*)
			if [ -f "$HOME/.bashrc" ]
			then
				source "$HOME/.bashrc"
			else
				echo "Can't find .bashrc" 1>&2
			fi
		;;
		*)
		;;
	esac
fi

