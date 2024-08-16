#!/bin/bash
#Location: /usr/bin, in case of other location, select-firefox-profile.desktop must be updated.

profile=$(zenity --height 250  --list --radiolist --text '' --column='Check' --column=Profile --title='Select your Firefox profile' TRUE "default-esr" FALSE "Craftspire" FALSE "Chrome" FALSE "Private")
if [ "$profile" == "Chrome" ]; then
    google-chrome $*
elif [ "$profile" == "Private" ]; then
    firefox --private-window $* &
else
    firefox $* -P $profile &
fi