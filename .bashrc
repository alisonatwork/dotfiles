if [ -f "$ENV" ]
then
	case "$ENV" in
		*.bashrc)
			echo "Circular ENV" 1>&2
			return
		;;
	esac
	case "$PS1" in
		'# '|'$ '|'')
		;;
		*)
			if [ "$USER" = "root" ]
			then
				PS1='# '
			else
				PS1='$ '
			fi
		;;
	esac
	source "$ENV"
elif [ -f "${HOME:-$USERPROFILE}/.bash_profile" ]
then
	if [ "$SHELL" = "/usr/bin/bash.exe" -a ! -x "`command -v uname`" ]
	then
		source /etc/profile
	fi
	source "${HOME:-$USERPROFILE}/.bash_profile"
else
	echo "Can't find ENV" 1>&2
fi
