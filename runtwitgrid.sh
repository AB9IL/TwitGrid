#!/bin/bash

# Copyright (c) 2021 by Philip Collier, github.com/AB9IL
# This script is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version. There is NO warranty; not even for
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# This script makes it easy to have a curated list of Twitter profiles to
# read on several topics.  You need TwitGrid and you need to keep several
# small topic files with a few Twitter handles in them (one handle per line).

# The syntax for topics is:
# one per line
# separate the topic name from the topic file with a comma
# Example:
# Linux,tw_linux

#==============================================================================
# User defined variables
# path to TwitGrid directory
twitpath="/usr/local/sbin/TwitGrid"

# path to topic files
topicpath=$twitpath

# List of topics
OPTIONS="Thinkers,tw_thinkers
Open Source Intelligence 0,tw_osint-1
Open Source Intelligence 1,tw_osint-2
Infosec,tw_infosec
Linux,tw_linux
CPU and GPU Technology,tw_cpugputech
Oil and Gas Industries,tw_oilgas
ADS-B Monitors,tw_adsb
USA Politics,tw_uspolitics
Renewable Energy,tw_renenergy
Radio Technology,tw_rftech
Software Defined Radio,tw_rfsdr
Shortwave Radio,tw_shortwave
Popular Traders,tw_traders
China Watch,tw_cnwatch
User Defined List,Userdefined"

# Browser command
BROWSER="x-www-browser --new-tab"

#==============================================================================
getlist(){
# Create a group of user-defined Twitter profiles.
PROFILE_LIST="$(rofi -dmenu -p "Enter one to five Twitter handles" )"
# Exit if no data is entered.
[[ -z "$PROFILE_LIST" ]] && echo "something went wrong" && exit 1
LISTSTRING=$PROFILE_LIST
}

# open a menu in Rofi or fzf
[[ "$1" == "gui" ]] && COMMAND="rofi -dmenu -p Select"
[[ "$1" == "gui" ]] || COMMAND="fzf --layout=reverse --header=Select:"

# Select the desired topic
REPLY=$(echo "${OPTIONS[@]}" | sed '/^$/d' | awk -F, '{printf $1"\n"}' | $COMMAND )

# Quit if no selection
[[ -z "$REPLY" ]] && echo "No selection made, exiting..." && exit 0

# Match the topic and list of profiles
PROFILES=$(echo "${OPTIONS[@]}" | grep "$REPLY" | awk -F, '{printf $2"\n"}')

# Quit if unable to get profiles
[[ -z "$PROFILES" ]] && echo "Something went wrong, exiting..." && exit 1

[[ "$PROFILES" == "Userdefined" ]] || readarray -t LIST < $topicpath/$PROFILES
[[ "$PROFILES" == "Userdefined" ]] && getlist

echo "
Reading handles from: "$PROFILES

# Convert LIST array string LISTSTRING if taking string from user input.
[[ "${#LIST[@]}" -gt "1" ]] && LISTSTRING=$(IFS=" "; echo "${LIST[*]}")

# Write the profile list into the html file
sed -i "s/const handlesTopInterests.*/const handlesTopInterests = \'$LISTSTRING\';/g" \
    $twitpath/twitgrid.html

#Start TwitGrid
$BROWSER $twitpath/twitgrid.html &> /dev/null

exit 0
