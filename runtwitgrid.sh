#!/bin/bash

# Copyright (c) 2021 by Philip Collier, github.com/AB9IL
# This script is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version. There is NO warranty; not even for
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# This script makes it easy to have a curated list of Twitter profiles to
# read on several topics.  You need TwitGrid and you need to keep one
# topic file with a few topics and Twitter handles.

# The syntax for topic file is:
# topic name, handle1 handle2 handle3 handle4 handle5
#
# Notes:
# no comments
# one topic per line
# separate the topic name from the Twitter hanhdles with a comma
# one space between Twitter handles
#
# Examples:
# Linux Experts, manjarolinux nixcraft itsfoss2 linux4everyone omgubuntu
# Open Source Intelligence, bellingcat auroraintel michaeldweiss Gerjon_ arictoler

#==============================================================================
# User defined variables
# path to TwitGrid directory
twitpath="/usr/local/sbin/TwitGrid"

# path to topic file
topicpath="$twitpath/tw_alltopics"

# Browser command
BROWSER="x-www-browser --new-tab"

#==============================================================================
# CAUTION: DRAGONS LIVE BELOW THIS LINE 
#==============================================================================
getlist(){
# Create a group of user-defined Twitter profiles.
[[ "$OPMODE" == "gui" ]] && PROFILE_LIST="$(rofi -dmenu -p "Enter one to five Twitter handles")"
[[ "$OPMODE" != "gui" ]] && echo "Enter one to five Twitter handles" && read PROFILE_LIST

# Exit if no data is entered.
[[ -z "$PROFILE_LIST" ]] && echo "something went wrong" && exit 1

PROFILES=$PROFILE_LIST
}

# define operating mode
OPMODE=$1

# read the bookmarks
readarray OPTIONS < $topicpath

# open a menu in Rofi or fzf
[[ "$OPMODE" == "gui" ]] && COMMAND="rofi -dmenu -p Select -lines ${#OPTIONS[@]}"
[[ "$OPMODE" == "gui" ]] || COMMAND="fzf --layout=reverse --header=Select:"

# Select the desired topic
REPLY=$(echo "${OPTIONS[@]}" | sed 's/^ //g;/^$/d' | awk -F, '{printf $1"\n"}' | $COMMAND )

# Quit if no selection
[[ -z "$REPLY" ]] && echo "No selection made, exiting..." && exit 0

# Match the topic and list of profiles
PROFILES=$(echo "${OPTIONS[@]}" | grep "$REPLY" | sed 's/^ //g;s/, /,/g' | awk -F, '{printf $2"\n"}')

# Quit if unable to get profiles
[[ -z "$PROFILES" ]] && echo "Something went wrong, exiting..." && exit 1

[[ "$PROFILES" == "Userdefined" ]] || LIST=$PROFILES
[[ "$PROFILES" == "Userdefined" ]] && getlist

echo "
Reading handles: $PROFILES"

# Write the profile list into the html file
sed -i "s/const handlesTopInterests.*/const handlesTopInterests = \'$PROFILES\';/g" \
    $twitpath/twitgrid.html

#Start TwitGrid
$BROWSER $twitpath/twitgrid.html &> /dev/null

exit 0
