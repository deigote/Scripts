#!/bin/bash
# change-gnome-wallpaper.sh - Randomly change gnome wallpaper using a wallpaper collection
#                             Intented to be used via cron or watch
# Author: Diego Toharia - diego@toharia.com
# Dependencies: 
#    * gconftool-2

WALLPAPERS_PATH="$HOME/Images/Wallpapers/"

TOTAL=`ls $WALLPAPERS_PATH | wc -l`
INDEX=$[ ( $RANDOM % $TOTAL )  + 1 ]
WALLPAPER="`ls $WALLPAPERS_PATH | head -n $INDEX | tail -n 1`"

gconftool-2 --type string --set /desktop/gnome/background/picture_filename "$WALLPAPERS_PATH/$WALLPAPER"
