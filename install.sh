#!/bin/sh

umask 022

dry_run=
if [ "$1" = "--dry-run" ]
then
	dry_run=echo
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

uname=`uname 2> /dev/null`

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
			$dry_run mv "$dest" "$dest.orig"
		fi
	fi
	$dry_run cp "$src" "$dest"
	unset src dest
}

installDir() {
	if [ ! -d "$2" ]
	then
		$dry_run mkdir -p "$2"
		$dry_run chmod $1 "$2"
	fi
}

installRecursive() {
	installDir 755 "$2/$1"
	for i in "$1"/*
	do
		if [ -d "$i" ]
		then
			installRecursive "$i" "$2"
		else
			installFile "$i" "$2/$i"
		fi
	done
}

for i in .[a-z]*
do
	if [ -d "$i" -o "$i" = ".gitattributes" ]
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

cd config
case "$uname" in
	MINGW*|MSYS_NT*)
		installRecursive Code "$APPDATA"
		installRecursive Packages "$LOCALAPPDATA"
		installRecursive nvim "$LOCALAPPDATA"
		installRecursive rg "$HOME/.config"
	;;
	Darwin)
		installRecursive Code "$HOME/Library/Application Support"
		installRecursive nvim "$HOME/.config"
		installRecursive rg "$HOME/.config"
	;;
	*)
		installRecursive Code "$HOME/.config"
		installRecursive nvim "$HOME/.config"
		installRecursive rg "$HOME/.config"
	;;
esac
cd ..

case "$uname" in
	MINGW*|MSYS_NT*)
		installFile apps/bc/dc.exe "$HOME/bin/dc.exe"
		psprofile=`powershell -command 'echo $profile.CurrentUserAllHosts' 2> /dev/null | cygpath -f - 2> /dev/null`
		if [ -n "$psprofile" ]
		then
			installDir 755 "`dirname $psprofile`"
			installFile profile.ps1 "$psprofile"
		fi
	;;
esac

cd scripts
for i in *
do
	installFile "$i" "$HOME/bin/$i"
done
cd ..

if [ -x "`command -v git`" ]
then
	$dry_run git config --global push.default simple
	$dry_run git config --global pull.rebase true
	$dry_run git config --global diff.algorithm histogram
fi

if [ -x "`command -v tic`" ]
then
	installRecursive .terminfo "$HOME"
	for i in "$HOME"/.terminfo/*.terminfo
	do
		$dry_run tic -o "$HOME/.terminfo" "$i"
	done
fi
