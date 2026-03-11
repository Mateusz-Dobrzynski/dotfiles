#!/bin/bash
#Location: /usr/bin, in case of other location, select-browser.desktop must be updated.
librewolf_text=LibreWolf
librewolf_private_text="LibreWolf Private"
chrome_text=Chrome
tor_text=Tor

profile=$(zenity --height 250  --list --radiolist --text '' --column='Check' --column=Profile --title='Select browser' TRUE "$librewolf_text" FALSE "default-esr" FALSE "$librewolf_private_text" FALSE "$chrome_text" FALSE "$tor_text")
if [ "$profile" == "$librewolf_text" ]; then
    librewolf $*
elif [ "$profile" == "$librewolf_private_text" ]; then
    librewolf --private-window $* &
elif [ "$profile" == "$chrome_text" ]; then
    google-chrome $*
elif [ "$profile" == "$tor_text" ]; then
    start-tor-browser $* &
elif [ "$profile" != "" ]; then
    firefox $* -P $profile &
fi