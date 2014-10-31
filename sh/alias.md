// Credit to https://stackoverflow.com/questions/941338/shell-script-how-to-pass-command-line-arguments-to-a-unix-alias/941390#941390

alias mkcd='_(){ mkdir $1; cd $1; }; _'
