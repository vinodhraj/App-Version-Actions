#!/bin/sh -l
input_file=$1
echo "\nInput file: $input_file"


if test -f $input_file; then
    content=$(cat $input_file)
else
    content=$(echo "-- File doesn't exist --")
fi

echo "\n$content"
echo "\nEnd of Action\n\n"