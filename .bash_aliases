# aliases should work with sudo and autocompletion
alias sudo='sudo '

# safe copies, moves, and makes
alias cp="cp -iv"
alias mv="mv -iv"
alias mkdir="mkdir -v -p"

# trash instead of delete
alias tp="trash-put"
alias tl="trash-list"
alias rm="trash-put"

# locations
alias dl="cd ~/Downloads"
alias www="cd /var/www/html"

# copy and paste from clipboard
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"

# execute last command as sudo
alias please='eval "sudo $(fc -ln -1)"'

# check internet connection
alias pong="ping google.com"

# get external ip
alias myip="curl --silent ifconfig.me"

# start http server in pwd
alias webshare="python -m SimpleHTTPServer 8080"

# find hosts on LAN
alias fing="fping -ga 192.168.1.0/24 2> /dev/null"

# remove last command from history (e.g. if password in clear)
alias scratch="history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))"

# change directory and list
function cdls() { cd "$*"; ls; }

# speak multiple words
function say() { echo mplayer -really-quiet "http://translate.google.com/translate_tts?tl=en\&q=$*" | sed 's/ /+/3g' | sh 2>/dev/null; }

# update and upgrade
alias suu="sudo apt-get update && sudo apt-get upgrade"

# install package
alias si="sudo apt-get install"

# show external connections
alias netext="netstat -tn"
alias listeners="netstat -tnl"

# go up one directory
alias ..="cd .."

# see who is on network
alias snitch='sudo nmap -sP 192.168.1.0/24 && echo "*** Further details in ~ One Minute, Please Wait ..." && sudo nmap 192.168.1.0/24'

# edit bash files
alias editalias="nano ~/.bash_aliases"
alias editbash="nano ~/.bashrc"

# find a file by name
alias f="find . |grep "

# find a process by name
alias p="[s aux |grep "

# open file as if double-clicked
alias o="xdg-open "

# generate website-specific password based on master password
function webpass() {
	website=$1
	stty -echo
	read -p "Password: " password
	echo
	stty echo

	echo "$password$website" | sha1sum - | cut -d" " -f1 | xxd -r -p | base64 | tr -d -c [:alnum:]
	echo
}

# telnet to weather underground
alias telrain="telnet rainmaker.wunderground.com"

# extract archive file
alias extract="atool -x"

# change prompt
function prompt () {
	[[ $# = 1 ]] || exit 255
	mode="$1"

	case "$mode" in
	none)
		export PS1=""
		;;
	off)
		export PS1="$ "
		;;
	date)
		export PS1="[\t]\$ "
		;;
	basic)
		export PS1="\[\e[36;1m\]\u@\h:\[\e[37;0m\]\w\$ \[\e[0m\]"
		#export PS1="\u:\w$ "
		;;
	full)
		export PS1="\[\e[37;1m\][\t] \[\e[36;1m\]\u@\h:\[\e[37;0m\]\w\$ \[\e[0m\]"
		#export PS1="[\t]\u:\w$ "
		;;
	esac
}

# start screen upon SSH
#if [ "$SSH_CONNECTION" ]; then
#	if [ -z "$STY" ]; then
#		exec screen -d -R
#	fi
#fi

# host-specific
#if [[ $HOSTNAME = 'unicorn' ]]; then
#	alias unicorn="nyancat"
#elif [[ $HOSTNAME = 'magic' ]]; then
#	alias magic="nyancat"
#else
#	echo "WARNING: Unrecognized machine: $HOSTNAME"
#fi

# log command output
function log_cmd() {
	local to_file="$1"
	shift
	if [ -z "$to_file" ]; then
		echo "Need a file to log to." 2>&1
		return 1
	elif [ -z "$*" ]; then
		echo "Need a command to run." 2>&1
		return 1
	fi

	echo "DATE: $(date)" > "$to_file"
	echo "DIR: $(pwd)" >> "$to_file"
	echo "CMD: $*" >> "$to_file"
	echo "OUTPUT:" >> "$to_file"
	echo >> $to_tile
	eval "$@ 2>&1 | tee -a '$to_file'"
	return $?
}
