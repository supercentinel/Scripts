#!/bin/bash
cd "${BASH_SOURCE%/*}" || exit
declare -A owers

# Read the file and store the values in the dictionary
while IFS= read -r line
do
    ower=$(echo "$line" | awk -F ',' '{print $1}')
    mail=$(echo "$line" | awk -F ',' '{print $2}')
    owers[$ower]=$mail
done < "$PWD/mails.csv"

for ower in "${!owers[@]}"
do
    #Create the directory where the files will be stored
    if [ ! -d "$ower" ]; then
        mkdir "$ower"
    fi

    #Create the file where only the name of the ower is present
    touch "$ower"/"$ower.csv"
    #Pull the data from the csv file and store it in the file
    grep -w "$ower" "$HOME"/Scripts/owes.csv > "$ower"/"$ower.csv"

    #Sums the total amount and appends it to the file
    total=$(awk -F ',' '{total += $2} END {print total}' "$ower/$ower.csv")

    echo "Total: $total" >> "$ower"/"$ower.csv"

    #Send mail
    mutt -s "Lista de adeudos" -a "$ower"/* -- "${owers[$ower]}" < /dev/null

    #Deleting the files
    rm "$ower"/*

    echo "$ower[${owers[$ower]}]"
done
