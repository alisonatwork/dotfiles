if [ -f "$ENV" ]
then
	if ! echo "$ENV" | grep -q .bashrc
	then
		source "$ENV"
	else
		echo "Circular ENV" 1>&2
	fi
else
	echo "Can't find ENV" 1>&2
fi

