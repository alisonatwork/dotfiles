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

UNAME=`uname 2> /dev/null`

installFile() {
	src="$1"
	dest="$2"
	if [ -f "$dest" ]
	then
		if diff -q "$dest" "$src" > /dev/null
		then
			return
		fi
		if [ -f "$dest.orig" ]
		then
			echo "Overwrite $dest? (y/N)"
			read response
			case "$response" in
				y|Y)
				;;
				*)
					echo "Skipping $dest..."
					continue
				;;
			esac
		else
			$DRY_RUN mv "$dest" "$dest.orig"
		fi
	fi
	$DRY_RUN cp "$src" "$dest"
	unset src dest
}

installDir() {
	if [ ! -d "$2" ]
	then
		$DRY_RUN mkdir -p "$2"
		$DRY_RUN chmod $1 "$2"
	fi
}

for i in .[a-z]*
do
	if [ -d $i -o "$i" = ".gitattributes" ]
	then
		continue
	fi
	installFile "$i" "$HOME/$i"
done

for i in .ssh mail
do
	installDir 700 "$HOME/$i"
done

for i in bin git src tmp
do
	installDir 755 "$HOME/$i"
done

if [ "$UNAME" = "Darwin" -a -z "$APPDATA" ]
then
	APPDATA="$HOME/Library/Application Support"
fi

if [ -d "$APPDATA" ]
then
	cd appdata
	for i in Code/User
	do
		installDir 755 "$APPDATA/$i"
		for j in $i/*
		do
			installFile "$j" "$APPDATA/$j"
		done
	done
	cd ..
fi

case "$UNAME" in
	MINGW*)
		installFile apps/bc/dc.exe "$HOME/bin/dc.exe"
	;;
	*)
	;;
esac

cd scripts
for i in *
do
	installFile "$i" "$HOME/bin/$i"
done
cd ..

if git --version > /dev/null 2>&1
then
	$DRY_RUN git config --global push.default simple
	$DRY_RUN git config --global pull.rebase true
fi

