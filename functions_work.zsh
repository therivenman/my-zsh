real_git="/usr/bin/git"
git()
{
    if [[ $1 == push ]]
    then
        if $real_git shortlog | grep PUSH > /dev/null
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

