#!/bin/bash
# rotate-images.sh - Script that rotates each image passed as parameter in
#                    a number of degrees (asked using a dialog). Intended to
#                    be used as a nautilus script in Gnome, is also possible to
#                    use it via command line
# Author: Diego Toharia - diego@toharia.com
# Dependencies: 
#    - ImageMagick
#    - gdialog (if not installed, -d <degrees> must be passed as paremter)

function usage
{
  echo "Usage: `basename $0` [<degrees>] photo.jpg other_photo.png"
  echo "Note that if degrees is not supplied, it will be asked via gdialog"
  echo "This allows the script to be used as a nautilus script in Gnome"
  exit 1
}

while getopts ":d" opt; do
  case $opt in
    u)
      DEGREES=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      ;;
  esac
done

if [[ -z "$DEGREES" ]] ; then
  if [[ -x "`which gdialog`" ]]; then
    DEGREES=`gdialog --title "Rotate images" --inputbox "Degrees (clock direction)" 200 450 2>&1` || exit
  else
    echo "No degrees supplied and gdialog not found in path!"
    usage
  fi
else
  shift
fi

[[ -d rotated ]] || mkdir rotated

while [ $# -gt 0 ]; do
    echo "Copying original '$1' into rotated directory..."
    cp $1 rotated/
    echo "Rotating '$1'..."
    convert -rotate $degrees $1 $1
    shift
done

