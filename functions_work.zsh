real_git="/usr/bin/git"
git()
{
    if [[ ($1 == svn) && ($2 == dcommit) ]]
    then
        if $real_git shortlog | grep -i dcommit > /dev/null
        then
            echo "******* CANCELLED ******* - Branch contains commits that can't be sent to the server."
            return 2
        fi
    fi
    $real_git "$@"
}

set_workspace ()
{
	if [ $# -ne 1 ]; then
		echo "Usage: $0 WORKSPACE_PATH"
		return
	fi

	if [ -d $1 ]; then
		echo "Workspace Dir set to $1"
		export CLIFFORD_DIR=$(readlink -m $1)
	else
		echo "$1 does not exist."
	fi
}

ticket_set ()
{
	if [ $# -ne 1 ]; then
		echo "Usage: $0 TICKET_NUMBER"
		return
	fi

	if [[ "$1" == "0" ]]; then
		echo "Ticket cleared."
		unset TICKET
	else
		echo "Ticket Number set to $1"
		export TICKET="$1"
	fi
}

workspace_scan ()
{
	repos=("${(@f)$(find $CLIFFORD_DIR -name .git 2>&1 | sed "s/\.git//" | grep -v "Permission")}")

	for ((i=0; i < ${#repos}; i++))
	do
		echo "Adding ${repos[$i]}."
		cd ${repos[$i]}
		_z --add "${PWD:A}"
	done

	echo "Done."
	cd $CLIFFORD_DIR
}

sync_dbus ()
{
	local current_dbus_sock=$(echo $DBUS_SESSION_BUS_ADDRESS)
	local tmux_dbus_sock=$(tmux showenv| grep DBUS_SESSION_BUS_ADDRESS|sed 's/DBUS_SESSION_BUS_ADDRESS=//')

	if [[ $current_dbus_sock != $tmux_dbus_sock ]]
	then
		DBUS_SESSION_BUS_ADDRESS=$tmux_dbus_sock
	fi
}

sync_qt ()
{
	local current_qt_session=$(echo $SESSION_MANAGER)
	local qt_session=$(tmux showenv| grep SESSION_MANAGER|sed 's/SESSION_MANAGER=//')

	if [[ $current_qt_session != $qt_session ]]
	then
		SESSION_MANAGER=$qt_session
	fi
}

function chpwd {
	sync_dbus
	sync_qt
}
