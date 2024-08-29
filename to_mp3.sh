#!/bin/bash

for track in ./*.flac; do
   ffmpeg -i "$track" -ab 320k -map_metadata 0 -id3v2_version 3 "mp3/${track%.*}.mp3"
done


# tracks=$(find . -name "*.flac" | sed 's/\.flac//g' | sed 's/^\.\///g')

# echo "$tracks"
# for track in $tracks
# do
#     echo "Converting $track"
# done
