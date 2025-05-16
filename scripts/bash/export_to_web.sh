#!/bin/bash

# info
echo ""
echo "Export der Punkte"
echo "================="
echo ""


# konfig
FILENAME="punkte"

LOGIN_WEBSERVER="user@server"
PATH_WEBSERVER="/path/to/the/website/"


# hilfsvariablen
FILENAME_SVG="${FILENAME}.svg"

WEBSERVER="${LOGIN_WEBSERVER}:${PATH_WEBSERVER}"


# los geht's :-)
echo ""
echo "1. Aktualisiere WEBSEITE"
echo "  scp $FILENAME_SVG ${LOGIN_WEBSERVER}"
scp "$FILENAME_SVG" "${WEBSERVER}${FILENAME_SVG}"
