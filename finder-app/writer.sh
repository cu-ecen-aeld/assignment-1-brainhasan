#!/bin/bash

# Prüfe, ob beide Argumente angegeben sind
if [ $# -ne 2 ]; then
    echo "Error: Zwei Argumente erforderlich: <Dateipfad> <Schreibtext>"
    exit 1
fi

# Argumente zuweisen
writefile=$1
writestr=$2

# Erstellen der notwendigen Verzeichnisse und Schreiben in die Datei
mkdir -p "$(dirname "$writefile")" # Erstellen des Verzeichnisses, falls es nicht existiert
echo "$writestr" > "$writefile"    # Schreiben in die Datei (überschreibt den Inhalt)

# Überprüfen, ob die Datei erstellt wurde
if [ ! -f "$writefile" ]; then
    echo "Error: Datei $writefile konnte nicht erstellt werden."
    exit 1
fi

