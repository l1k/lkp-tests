# common utility functions

. $LKP_SRC/lib/debug.sh

is_abs_path()
{
	[[ "${1:0:1}" = "/" ]]
}

abs_path()
{
	local path="$1"
	if is_abs_path $path; then
		echo $path
	else
		echo $PWD/$path
	fi
}

query_var_from_yaml()
{
	local key=$1
	local yaml_file=${2:--}
	[ $# -ge 1 ] || die "Invalid parmeters: $*"

	sed -ne "1,\$s/^$key[[:space:]]*:[[:space:]]*\\(.*\\)[[:space:]]*\$/\\1/p" "$yaml_file"
}

# null string, or string starts with 0 or no are false, otherwise true
parse_bool()
{
	if [ "$1" != "-q" ]; then
		otrue=1
		ofalse=0
	else
		shift
	fi
	[ -z "$1" ] && { echo $ofalse; return 1; }
	[ "${1#0}" != "$1" ] && { echo $ofalse; return 1; }
	[ "${1#no}" != "$1" ] && { echo $ofalse; return 1; }
	echo $otrue; return 0
}
