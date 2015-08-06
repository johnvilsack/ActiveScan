#! /bin/bash
source includes.sh

read -r -p "Are you sure? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    rm -rf src/;
    rm $CORDOVA_NAME.xcodeproj;
else
    echo 'Cancelled.';
fi