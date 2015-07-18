#!/bin/sh

DRY_RUN=
if [ "$1" = "--dry-run" ]
then
	DRY_RUN=echo
	shift
fi

if [ -n "$1" ]
then
	echo "$0: No args" 1>&2
	exit 1
fi

if [ -z "$HOME" ]
then
	if [ -z "$USERPROFILE" ]
	then
		echo "$0: Can't find HOME" 1>&2
		exit 1
	fi
	HOME="$USERPROFILE"
fi

case "$0" in
	./install.sh)
	;;
	*)
		cd `dirname $0` 2> /dev/null
	;;
esac

for i in .[a-z]*
do
	if [ -d "$i" ]
	then
		continue
	fi
	if [ -f "$HOME/$i" ]
	then
		if diff -q "$HOME/$i" "$i" > /dev/null
		then
			continue
		fi
		if [ -f "$HOME/$i.orig" ]
		then
			echo "Overwrite $HOME/$i? (y/N)"
			read response
			case "$response" in
				y|Y)
				;;
				*)
					echo "Skipping $HOME/$i..."
					continue
				;;
			esac
		else
			$DRY_RUN mv "$HOME/$i" "$HOME/$i.orig"
		fi
	fi
	$DRY_RUN cp "$i" "$HOME/$i"
done

makeDir() {
	if [ ! -d "$HOME/$1" ]
	then
		$DRY_RUN mkdir "$HOME/$1"
		$DRY_RUN chmod $2 "$HOME/$1"
	fi
}

for i in .ssh mail
do
	makeDir $i 700
done

for i in bin git src tmp
do
	makeDir $i 755
done

if git --version > /dev/null 2>&1
then
	$DRY_RUN git config --global push.default simple
	$DRY_RUN git config --global pull.rebase true
	$DRY_RUN git config --global color.ui false
fi

