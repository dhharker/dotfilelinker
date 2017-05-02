# Dotfile Linker

**What** Creates symlinks from a shared folder (with e.g. dropbox or [syncthing](https://syncthing.net)) to your dotfiles.

**Why** Makes provisioning new machines easier when you keep your dotfiles in file sync.

**How** Badly written `bash` (I don't even know bash scripting so this is just ugly).

## Setup

1.	Put `use_synched_configs.sh` somewhere, I keep it in my synced dotfiles folder.
2.	Edit the file to reference what you want to copy from your sync to your system.
3.	When you setup a new machine, sync the dotfiles and run the script to link them.

## @TODO

 - [ ] Option to (backup then) delete existing files for selected target files
 - [ ] Ability to link all files from a synced folder to a target folder without making the target folder itself a link
 - [ ] Add CLI help to explain the stupid coloured ascii art which indicates target/source state
