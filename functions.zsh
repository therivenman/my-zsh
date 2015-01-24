down ()
{
    local num_dirs=$1
    local downdirs=""

	if [ -z $num_dirs ]; then
		echo "Usage: down num_dirs"
	else
		for i in $(seq $num_dirs); do
			downdirs=$downdirs"../"
		done

		cd $downdirs
	fi
}
