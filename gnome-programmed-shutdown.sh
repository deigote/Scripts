#!/bin/bash
# gnome-programmed-shutdown.sh - A script that shutdown the computer after some time
#                                asked in minutes using a graphical dialog and progress bar
# Author: Diego Toharia - diego@toharia.com
# Screenshots: http://blog.deigote.com/2009/04/17/programmed-shutdown-pequeno-script-para-apagar-la-maquina/
# Dependencies:
#   * zenity (modern gdialog replacement)

# Messages
TITLE="Shutdown the computer"
MINUTES_QUESTION="How much minutes should I wait?"
WAIT_PRE="Waiting"
WAIT_POST="minutes"

minutes=`zenity --entry --title "$TITLE" --text "$MINUTES_QUESTION" 2>&1` || exit
seconds=`expr $minutes "*" 60`

if [ $seconds != "" ] ; then
	for i in `seq 1 $seconds` ; do
		percentage=`expr $i "*" 100`
		percentage=`expr $percentage "/" $seconds`
		echo $percentage
		sleep 1
	done | zenity --title="$TITLE" --text="$WAIT_PRE $minutes $WAIT_POST" --progress --auto-close --auto-kill
	poweroff
fi
