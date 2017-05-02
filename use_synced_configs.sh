#!/bin/bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "--- UPDATING CONFIG LINKS"

green='\e[0;32m'
red='\e[0;31m'
yellow='\e[0;33m'
cyan='\e[0;36m'
endColor='\e[0m'


function link_configs {
	FILE=$1
	SYNCED_FILE=$2
	if [[ -L "$FILE" ]];
	then
	    echo -e " ${green}><${endColor} `basename $SYNCED_FILE`"
	else
	    # echo "$FILE is not a symlink";

		if [[ -e "$FILE" ]];
		then
			if [ -e "$SYNCED_FILE" -a -d "$SYNCED_FILE" ]
			then
				echo -e " ${yellow}<>${endColor} $FILE"
			else
				echo -e " ${yellow}<>${endColor} `basename $FILE`"
			fi
		else
			if [[ -e "$SYNCED_FILE" ]];
			then
				if [ -d "$(dirname \"$FILE\")" ]
				then
					echo -e " ${yellow}>|${endColor} $(dirname "$FILE") missing. Won't create link to `realpath $SYNCED_FILE`"
				else
					# it's not (a dir with an existing target)
					echo -e " ${cyan}++${endColor} ln -s $SYNCED_FILE $FILE"
					ln -s "$SYNCED_FILE" "$FILE"
				fi
			else
				echo -e " ${red}!!${endColor} $SYNCED_FILE does not exist!"
			fi

		fi
	fi
}


# Assumes that the parent dir is the syncthing share (probably "Documents")
link_configs "$DIR/../.stignore" "$DIR/stignore"
link_configs "$DIR/../.stinclude" "$DIR/stinclude"

# Sync SSH known_hosts and github keypair
mkdir -p "$HOME/.ssh"
link_configs "$HOME/.ssh/gh_id_rsa" "$DIR/ssh/gh_id_rsa"
link_configs "$HOME/.ssh/gh_id_rsa.pub" "$DIR/ssh/gh_id_rsa.pub"
link_configs "$HOME/.ssh/known_hosts" "$DIR/ssh/known_hosts"

# screen
link_configs "$HOME/.screenrc" "$DIR/screenrc"

# git
link_configs "$HOME/.gitconfig" "$DIR/gitconfig"

# sublime
# run sublime, install package control, quit sublime, delete the 'User' target dir, run this script, restart sublime
link_configs "$HOME/.config/sublime-text-3/Packages/User" "$DIR/subl"

echo "--- DONE"
