#! /bin/bash
while true; do
    read -p "This will delete the src folder completely. Are you sure?" yn
    case $yn in
        [Yy]* ) rm -rf src/; rm *.xcodeproj; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done