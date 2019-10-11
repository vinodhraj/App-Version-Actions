#!/bin/sh -l
file_name=$1
echo "\nInput file: $file_name"


if test -f $file_name; then
    content=$(cat $file_name)
else
    content=$(echo "-- File doesn't exist --")
fi

echo "\n$content"
echo "\nEnd of Action\n\n"