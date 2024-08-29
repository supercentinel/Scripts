mkdir withCover

for track in *.flac;
do
    ffmpeg -i "$track" -i "./1978 12 11 tokyo (stage at budokan) - front.jpg" -map 0:0 -map 1:0 -c copy -id3v2_version 3 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (front)" withCover/"$track"
done
