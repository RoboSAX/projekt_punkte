#!/bin/bash

# info
echo ""
echo "Export der Punkte"
echo "================="
echo ""


# konfig
FILENAME="punkte"

PATH_WEBSERVER="/run/user/1001/gvfs/sftp:host=server-name.de,user=user-name/"


# hilfsvariablen
FILENAME_SVG="${FILENAME}.svg"


# los geht's :-)
echo ""
echo "1. Aktualisiere WEBSEITE"
if [ -d "${PATH_WEBSERVER}" ]; then
    echo "  cp $FILENAME_SVG ..."
    cp "$FILENAME_SVG" "${PATH_WEBSERVER}${FILENAME_SVG}"
else
    echo ""
    echo "  Webserver ist nicht eingehangen :-("
    echo "  --> Kann kein Backup online speichern"
fi
