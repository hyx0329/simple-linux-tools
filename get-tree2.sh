#!/bin/sh

##############################
## get-tree2 bash tool      ##
## written by Huang Yunxuan ##
## E-mail: hyx0329@163.com  ##
##############################

dir="$(pwd)/"
pfile="print_relative"
fun="get_tree2"
wdir=0

print_relative()
{
current="$(pwd)/$file"
echo ${current#$dir}
}

print_absolute()
{
echo "$(pwd)/$file"
}



get_tree2()
{
    set -e
    
    for file in `dir -1 $arg`; do
        if test -f $file; then
            $pfile
        elif test -d $file; then
            $pdir
            cd $file
            get_tree2
            cd ..
        fi
    done
}

get_diagram()
{
echo "get_diagram is not functional yet"
}


while [ $# -gt 0 ] 
do
    case "$1" in
    -a)
    arg="$arg -A"
    ;;
    -d)
    wdir=1
    ;;
    -f)
    pfile="print_absolute"
    ;;
    -t)
    fun="get_diagram"
    ;;
    -h|--help|*)
      echo "This is a simple tool to write down directories "
      echo " under current directory
      echo "Usage:"
      echo "-h,--help                  show this info"
      echo "-a                         include hidden files"
      echo "-d                         include empty directory"
      echo "-f                         show absolute path s(full path)"
      echo "-t                         get an easy-read tree diagram (not functional yet)"
      echo ""
      echo "e.g. ./get-tree2 -a -f"
      echo "default: hide empty folder, show relative path"
      exit 0
    ;;
    esac
    shift
done

if [ $wdir -eq 1 ]; then
pdir="$pfile"
fi


$fun