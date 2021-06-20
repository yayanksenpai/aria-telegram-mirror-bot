#!/bin/bash

# To set a different value other than default(5), remove `#` from below line and replace the value
#MAX_CONCURRENT_DOWNLOADS=5

wget -q $CREDENTIALS -O /bot/credentials.json
wget -q $CLIENT_SECRET -O /bot/client_secret.json
wget -q $CONSTANTS_URL -O /bot/out/.constants.js

if [[ -n $MAX_CONCURRENT_DOWNLOADS ]]; then
	sed -i'' -e "/max-concurrent-downloads/d" $(pwd)/aria.conf
	echo -e "max-concurrent-downloads=$MAX_CONCURRENT_DOWNLOADS" >> $(pwd)/aria.conf
fi

sed -i'' -e "/bt-tracker=/d" $(pwd)/aria.conf
tracker_list=`curl -Ns https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt | awk '$1' | tr '\n' ',' | cat`
echo -e "bt-tracker=$tracker_list" >> $(pwd)/aria.conf

# Remove the .bak file got created from above sed
test -f $(pwd)/aria.conf-e && rm $(pwd)/aria.conf-e

aria2c --conf-path=aria.conf && echo "Aria2c daemon started"

http-server -p $PORT &
npm start
