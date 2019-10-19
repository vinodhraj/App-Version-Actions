#!/bin/sh -l

file_name=$1
tag_version=$2
echo "\nInput file name: $file_name : $tag_version"

([ -z "$GITHUB_ONLY_ON_COMMIT" ]) || exit 0

if test -f $file_name; then
    content=$(cat $file_name)
else
    content=$(echo "-- File doesn't exist --")
fi

echo "File Content:\n$content"

regex="^(v|ver|version|V|VER|VERSION)|(\s*)|([0-9]{1,2}(\.+)){3}([0-9]{1,3})$"

#^([0-9]{1,2})+[.]+([0-9]{1,2})+[.]+([0-9]{1,2})
#echo "ver 0.0.12.456" | 
#awk '/(v|ver|version|V|VER|VERSION)?([0-9]{1,2})+[.]+([0-9]{1,2})+[.]+([0-9]{1,3})|[.]+([0-9]{1,3})$/{print $0}' version
#echo "$ver" | grep "(v|ver|version|V|VER|VERSION)?([0-9]{1,2})+[.]+([0-9]{1,2})+[.]+([0-9]{1,3})|[.]+([0-9]{1,3})*$")

extract_string=$(awk '/^(v|ver|version|V|VER|VERSION)?[[:blank:]]*([0-9]{1,2})\.([0-9]{1,2})\.([0-9]{1,3})(\.([0-9]{1,3}))?$/{print $0}' $file_name)
echo $extract_string


if [[ $content = $extract_string ]]; then 
    echo "\nValid Version string found\n"
else
    echo "\nInvalid Version string\n"
    exit 1
fi

major=$(echo $content | cut -d'.' -f1) 
major=${major:(-2)}
minor=$(echo $content | cut -d'.' -f2)
patch=$(echo $content | cut -d'.' -f3)
build=$(echo $content | cut -d'.' -f4)


#echo $major 
#echo $minor
#echo $patch

if [[ $build = "" ]]; then
    oldver=$(echo $major.$minor.$patch)
    patch=$(expr $patch + 1)
    newver=$(echo $major.$minor.$patch)
else
    oldver=$(echo $major.$minor.$patch.$build)
    build=$(expr $build + 1)
    newver=$(echo $major.$minor.$patch.$build)
fi
echo "\nOld Ver: $oldver"

echo "\nUpdated version: $newver" 

newcontent=$(echo ${content/$oldver/$newver})

echo $newcontent > $file_name

echo "\nStarting Git Operations"
git config --global user.email "MobileAppVersioner@github-action.com"
git config --global user.name "Mobile App Versioner"

git add -A 
git commit -m "Incremented to ${newver}"  -m "[skip ci]"
([ -n "$tag_version" ] && [ "$tag_version" = "true" ]) && (git tag -a "${newver}" -m "[skip ci]") || echo "No tag created"

git show-ref
git push --follow-tags "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" HEAD:${GITHUB_REF}


echo "\nEnd of Action\n\n"
exit 0