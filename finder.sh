#!/bin/bash

# Prüfe, ob beide Argumente angegeben sind
if [ $# -ne 2 ]; then
    echo "Error: Zwei Argumente erforderlich: <Verzeichnis> <Suchstring>"
    exit 1
fi

# Argumente zuweisen
filesdir=$1
searchstr=$2

# Prüfen, ob das erste Argument ein Verzeichnis ist
if [ ! -d "$filesdir" ]; then
    echo "Error: $filesdir ist kein Verzeichnis."
    exit 1
fi

# Zählen der Dateien und Übereinstimmungen
num_files=$(find "$filesdir" -type f | wc -l)
num_matching_lines=$(grep -r "$searchstr" "$filesdir" 2>/dev/null | wc -l)

# Ausgabe der Ergebnisse
echo "The number of files are $num_files and the number of matching lines are $num_matching_lines"
