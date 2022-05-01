#!/bin/bash
latest=""
while IFS= read -r line; do
    if [[ $(semver compare ${line} ${latest} 2> /dev/null) = '1' ]]; then
        latest=${line}
    fi
    #echo "... $line ..."
done <<< "$(git tag)"
echo $latest
