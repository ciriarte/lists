// Credit to https://stackoverflow.com/questions/941338/shell-script-how-to-pass-command-line-arguments-to-a-unix-alias/941390#941390

alias mkcd='_(){ mkdir $1; cd $1; }; _'

// One day, a wiser, mature me will question the nature of these aliases
alias fucknode="rm -rf node_modules && rm -rf bower_components"
alias nodeplz="npm install && bower install"
alias omgnode="fucknode && nodeplz"
alias fuckingphantom="pkill -9 -f phantomjs"
