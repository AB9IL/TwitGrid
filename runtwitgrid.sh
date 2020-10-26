#!/bin/bash

# Copyright (c) 2020 by Philip Collier, radio AB9IL <webmaster@ab9il.net>
# This script is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version. There is NO warranty; not even for
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#==============================================================================
# User defined variables
# path to TwitGrid diirectory
twitpath="$HOME/bash/TwitGrid"

# Command to open the html page in a browser.
BROWSER="x-www-browser"

#==============================================================================
echo ""
echo "Run TwitGrid using a list of Twitter accounts."
echo ""
echo "Please select one of the following options:

1 Infosec
2 Linux
3 Oil and Gas Industries
4 Open Source Intelligence
5 Politics
6 Renewable Energy
7 Radio Technology
8 Software Defined Radio
9 Shortwave Radio
10 Popular Traders
11 User Defined List
"
# Take the choice; exit if no answer given.
read;
[[ -z "$REPLY" ]] && echo "something went wrong" && exit 1

case $REPLY in
    1) readarray -t LIST < $twitpath/tw_infosec;;
    2) readarray -t LIST < $twitpath/tw_linux;;
    3) readarray -t LIST < $twitpath/tw_oilgas;;
    4) readarray -t LIST < $twitpath/tw_osint;;
    5) readarray -t LIST < $twitpath/tw_politics;;
    6) readarray -t LIST < $twitpath/tw_renenergy;;
    7) readarray -t LIST < $twitpath/tw_rftech;;
    8) readarray -t LIST < $twitpath/tw_rfsdr;;
    9) readarray -t LIST < $twitpath/tw_shortwave;;
    10) readarray -t LIST < $twitpath/tw_traders;;
    11)  # Create a group of user-defined Twitter profiles.
        echo -n "Please enter one to five Twitter handles: ";
        read;
        # Exit if no data is entered.
        [[ -z "$REPLY" ]] && echo "something went wrong" && exit 1
        LISTSTRING=$REPLY
        ;;
    *)
        echo "Please enter a given option, or a blank line to exit."
        exit 1
        ;;
esac

# Convert LIST array string LISTSTRING if taking string from user input.
[[ "${#LIST[@]}" -gt "1" ]] && LISTSTRING=$(IFS=" "; echo "${LIST[*]}")

# Write the profile list into the html file
sed -i "s/const handlesTopInterests.*/const handlesTopInterests = \'$LISTSTRING\';/g" \
    $twitpath/twitgrid.html
#Start TwitGrid
$BROWSER $twitpath/twitgrid.html &

exit 0
