#!/bin/bash

# Standardwerte setzen
numfiles=${1:-10}                # Anzahl der Dateien, Standard ist 10
writestr=${2:-"AELD_IS_FUN"}     # String, der in jede Datei geschrieben wird, Standard ist "AELD_IS_FUN"

script_dir=$(dirname "$0")         # Verzeichnis, in dem das Skript liegt
testdir="$script_dir/tmp/aeld-data"
rm -rf "$testdir"   # Verzeichnis löschen, falls es bereits existiert
mkdir -p "$testdir" # Leeres Verzeichnis erstellen

# Username aus conf/username.txt lesen
username=$(cat conf/username.txt)

# Testdateien mit writer.sh erstellen
for i in $(seq 1 $numfiles); do
    writefile="$testdir/${username}${i}.txt"
    ./writer.sh "$writefile" "$writestr"
    if [ $? -ne 0 ]; then
        echo "Error: writer.sh konnte $writefile nicht erstellen"
        exit 1
    fi
done

# finder.sh ausführen und Ausgabe überprüfen
output=$(./finder.sh "$testdir" "$writestr")
expected_output="The number of files are $numfiles and the number of matching lines are $numfiles"

# Prüfen, ob die Ausgabe wie erwartet ist
if [ "$output" == "$expected_output" ]; then
    echo "success"
else
    echo "error"
    echo "Erwartete Ausgabe: $expected_output"
    echo "Erhaltene Ausgabe: $output"
fi

