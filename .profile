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

TERM=xterm
export TERM

if [ -d "$HOME/bin" ]
then
	if ! echo "$PATH" | egrep -q "^$HOME[/\\]bin"
	then
        PATH="$HOME/bin:`echo $PATH | sed \"s|$HOME[/\\]bin:||\"`"
        export PATH
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

