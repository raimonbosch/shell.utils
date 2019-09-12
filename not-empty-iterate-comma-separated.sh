#!/bin/sh

# The script checks if variables are empty and iterates a comma separated string if exists.

HOTEL_ID=
HOTEL_IDS=1,2

if [ ! -z "$HOTEL_ID" ]
then
    echo $HOTEL_ID
elif [ ! -z "$HOTEL_IDS" ]
then
    for hotelId in $(echo $HOTEL_IDS | sed "s/,/ /g")
    do
        echo $hotelId 
    done
else
    echo "Learn shell script, please."
fi
