#!/bin/bash

#The following script is used to log exercise data and display a timer for each exercise

excercises=("Pushups" "Bicep Curls" "Tricep Extensions" "Shoulder Flys" "Forearm Curls")
abrs=("PS-UP" "B-CRL" "T-EXT" "S-FLYS" "F-CRL")

daytime=$(date -I)
logname="$HOME/Scripts/Exercise/Logs/exercise-$daytime.csv"
logstring=""

touch "$logname"

logstring="Exercise,Time"
echo "$logstring" > "$logname"

speak-ng "Warmup"
termdown 5m --blink --title "WARMUP"

for i in "${!excercises[@]}"; do
  for ((j=1; j<= $1; j++)) do
    logstring="${excercises[$i]} $j,"
    speak-ng "${excercises[$i]} $j"
    start=$(date +%s)

    termdown --title "${abrs[$i]} $j"

    end=$(date +%s)
    compTime=$((end-start))
    logstring+="$compTime"
    echo "$logstring" >> "$logname"

    #End of routine does not require a rest
    speak-ng "Rest"
    termdown 1m --title "REST"
    echo "Rest,60" >> "$logname"
  done
done
