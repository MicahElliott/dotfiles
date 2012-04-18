# ecd — Enhanced CD (for bash)
#
# Author:  Micah Elliott http://MicahElliott.com
# License: WTFPL http://sam.zoy.org/wtfpl/
#
# Usage: source .../ecd.sh; cd ...
# (Don’t try to run this file; it is to be sourced)
#
# Useful aliases:
# alias cdl='cd -l'
# alias cde='vim -o2 .enterrc .exitrc'
#
# NOTE: I no longer use this script since switching to zsh, where I
# rely on more powerful versions of pushd (pu), popd (po), cd, and chpwd
# hook.  But, this still is useful in bash if:
# * you find pushd/popd counterintuitive (I did for a long time)
# * want a menu-driven history
# * like the notion of .enterrc/.exitrc per directory
# * would like to see a clever example of full-path ascension/descension.
#
# See O’Reilly’s Power Tools book for an example of sprinkling these
# little files around.
#
# History:
# * 2003: Written and used by a few folks at Intel, shared on freshmeat.
# * 2008: Expanded to multi-shell/OS, re-wrote in Python, many feature *ideas*
# * 2009: Micah adopts zsh
# * 2011: Posted to github in case someone still wants to use it
#
# NOTE: You might not want to name the workhorse function ‘cd’. If
# it’s uncomfortable, you could use ‘c’ or ‘ecd’.
#
# See README for ideas to expand this.

declare -a _dirstack
_dirstack=($HOME)
#echo "_dirstack array set to ${_dirstack[*]}"

_cd_dbg() { (( $debug )) && _cd_msg "debug: $@"; }
_cd_vbs() { (( $verbose )) && _cd_msg "$@" 1>&2; }
_cd_msg() { echo -e "cd: $@" 1>&2; }

_cd_cleanup() { trap INT; OPTERR=1 OPTIND=1; }

_cd_misuse() {
    echo "cd: illegal option -- $OPTARG"
    echo "Try \`cd -h' for more information."
}

_cd_usage() {
    echo "Usage: cd [OPTION] [DIR]"
    echo "Change the current directory to DIR, searching for hidden"
    echo "source-able files named \`.enterrc' and \`.exitrc'."
    echo
    echo "  -h   display help message and exit"
    echo "  -l   list history and select new directory from menu"
    echo "  -v   verbose mode"
    echo
    echo "Report bugs to <mde@MicahElliott.com>"
}

# Ascend upward in dir hierarchy searching for and sourcing .exitrc files
_cd_ascend() {
    # Don’t ascend if cwd is ‘/’
    if [ "$orig" = "/" ]; then return; fi

    # Ascend all the way to common base dir
    _cd_vbs "Ascending -- searching for files of type .exitrc"
    tmp_orig_ext=/$orig_ext
    while [ "${tmp_orig_ext}" != "${tmp_orig_ext%%/*}" ]; do
        _cd_dbg "Searching '${common}${tmp_orig_ext}' for '.exitrc'"
        if [ -e "${common}$tmp_orig_ext/.exitrc" ]; then
            _cd_vbs "Found and sourced ${common}$tmp_orig_ext/.exitrc"
            source "${common}/${tmp_orig_ext}/.exitrc"
        fi
        tmp_orig_ext="${tmp_orig_ext%/*}"
    done
}

# Descend downward in dir hierarchy searching for and sourcing .enterrc files
_cd_descend() {
    # Descend to ‘new_ext’
    _cd_vbs "Descending -- searching for files of type .enterrc"
    tmp="$common"
    for dir in ${new_ext//\// }; do
        tmp="${tmp}/${dir}"
        _cd_dbg "Searching '${tmp}' for '.enterrc'"
        if [ -e "$tmp/.enterrc" ]; then
            _cd_vbs "Found and sourced $tmp/.enterrc"
            source "$tmp/.enterrc"
        fi
    done
}

cd() {
    trap '_cd_cleanup; return 2;' INT

    # Declare local vars
    local orig new orig_list new_list orig_ext new_ext common maxsize list_dirs
    local opt dir verbose debug tmp tmp_orig_ext comm_tmp abort
    let maxsize=10 list_dirs=0 verbose=0
    #let debug=0
    let debug=${DEBUG:-0}
    (( $debug )) && let verbose=1

    ### PART 1: Parse command-line options

    while getopts ":hlv" opt; do
        case $opt in
            h ) _cd_usage; _cd_cleanup; return 1 ;;
            l ) let list_dirs=1 ;;
            v ) let verbose=1 ;;
            \? ) _cd_misuse; _cd_cleanup; return 1;;
        esac
    done
    shift $(($OPTIND - 1))

    # Indicate activated modes
    (( $list_dirs )) && _cd_vbs "<<list_dirs mode set>>"
    (( $verbose )) && _cd_vbs "<<verbose mode set>>"

    # `orig' is original directory
    orig=$(pwd)
    _cd_dbg "orig      = $orig"

    ### PART 2: Determine functional mode: interactive or not

    # Interactive list mode
    if (( $list_dirs )); then
        # If stack is empty bail out
        if (( ${#_dirstack[*]} < 2 )); then
            _cd_msg "stack is empty -- nothing to list"; _cd_cleanup; return 1;
        fi

        # FIXME: Maybe add color to this prompt ??
        PS3="Enter your selection: "
        # Choose from dirs on stack, excluding the first dir
        select d in $(echo ${_dirstack[*]} | sed 's:[^ ]*::') "<<exit>>"; do
            if [ "$d" = "<<exit>>" ]; then
                _cd_cleanup; let abort=1; break;
            elif [ $d ]; then
                new="$d";
                if ! builtin cd "$d"; then _cd_cleanup; return 1; fi
                break;
            else
                echo "Invalid choice -- try again"
            fi
        done
        (( abort )) && return 0;

    # Non-interactive mode
    else
        # `new' is destination directory -- must cd there to obtain abs path
        if (( $# > 0 )); then
            if ! builtin cd "$1"; then _cd_cleanup; return 1; fi
            new=$( echo $(pwd) | sed 's:///*:/:' )
        else # $# = 0
            builtin cd $HOME
            new=$(pwd)
        fi
    fi
    _cd_dbg "new       = $new"

    ### PART 3: Add dir to stack

    # Don’t want ‘/’ on stack
    if [ "$new" = "/" ]; then :
    else
        # If already in list move to front and remove later entry
        if echo "${_dirstack[*]} " | /bin/grep -q "$new "; then
            _cd_dbg "$new already on stack -- moving to front."
            _dirstack=($new $( echo "${_dirstack[*]} " | sed "s:$new ::" ))

            # Else just add to _dirstack
        else
            _dirstack=($new ${_dirstack[*]})
        fi

        # Check for length too long
        if (( ${#_dirstack[*]} > $maxsize )); then
            _cd_dbg "reached max size -- unsetting index "${#_dirstack[*]}-1
            unset _dirstack[${#_dirstack[*]}-1]
        fi
    fi

    ### PART 4: Search for files of type .exitrc and .enterrc (ascension/descension)

    ### CASE 0: No-op if `cd .' or `cd ' and already in $HOME
    if [ "$orig" = "$new" ]; then
        _cd_msg "You're already there, silly."
        _cd_cleanup; return 1;
    fi

    ### Some magic to determine commonality of orig and new dirs

    orig_list=$(echo $orig | sed -e 's:^/::' -e 's:/:\\n:g')
    new_list=$(echo $new | sed -e 's:^/::' -e 's:/:\\n:g')

    comm_tmp=$(comm --nocheck-order -12 <(echo -e "$orig_list") <(echo -e "$new_list"))
    common=$(echo $comm_tmp | sed -e 's:^:/:' -e 's: :/:g')
    if [ "$common" = "/" ]; then common=""; fi

    comm_tmp=$(comm --nocheck-order -23 <(echo -e "$orig_list") <(echo -e "$new_list"))
    orig_ext=$(echo $comm_tmp | sed -e 's: :/:g')

    comm_tmp=$(comm --nocheck-order -13 <(echo -e "$orig_list") <(echo -e "$new_list"))
    new_ext=$(echo $comm_tmp | sed -e 's: :/:g')

    _cd_dbg "common    = $common"
    _cd_dbg "orig_ext  = $orig_ext"
    _cd_dbg "new_ext   = $new_ext"

    ### CASE 1: Moving to entirely new hierarchy of `/'
    if [ -z "$common" ]; then
        _cd_dbg "CASE1: $new and $orig have no common base"
        _cd_ascend
        _cd_descend

    ### CASE 2: Descending to some subdir of orig
    elif [ -z "$orig_ext" ]; then
        _cd_dbg "CASE2: Descending to $new_ext"
        _cd_descend

    ### CASE 3: Ascending to some parent in the hierarchy, but still common base
    else
        _cd_dbg "CASE3: Ascending to $common"
        _cd_ascend

        # CASE 3.1: Descend to `new_ext', sourcing all .enterrc's
        if [ -n "$new_ext" ]; then
            _cd_dbg "CASE3.1: Descending to $new_ext"
            _cd_descend

        # CASE 3.2: New dir is a direct parent -- no descension
        else
            _cd_dbg "CASE3.2: new_ext is null -- no descending"
            new_ext="."
            _cd_descend #trial
        fi

    fi

    ### PART 5: End

    _cd_vbs "_dirstack = ${_dirstack[*]}"
    _cd_cleanup; return 0;
}

