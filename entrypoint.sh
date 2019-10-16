#!/bin/sh -l
file_name=$1
echo "\nInput file name: $file_name"


if test -f $file_name; then
    content=$(cat $file_name)
else
    content=$(echo "-- File doesn't exist --")
fi

echo "File Content:\n$content"

regex="^(v|ver|version|V|VER|VERSION)|(\s*)|([0-9]{1,2}(\.+)){3}([0-9]{1,3})$"
#ld="[0-9]$"
#echo $regex

#if [[ $content =~ $regex ]]; then 
#    echo "\nValid Version string found\n"
#else
#    echo "\nInvalid Version string\n"
#    exit 1
#fi

major=$(echo $content | cut -d'.' -f1) 
major=${major:(-2)}
minor=$(echo $content | cut -d'.' -f2)
patch=$(echo $content | cut -d'.' -f3)
build=$(echo $content | cut -d'.' -f4)

oldver=$(echo $major.$minor.$patch.$build)
echo "\nOld Ver: $oldver"

#echo $major 
#echo $minor
#echo $patch
build=$(expr $build + 1)
#echo $build

newver=$(echo $major.$minor.$patch.$build)

echo "\nUpdated version: $newver" 

newcontent=$(echo ${content/$oldver/$newver})

echo $newcontent > $file_name

echo "\nEnd of Action\n\n"
exit 0