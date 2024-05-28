# info
echo ""
echo "Backup & Check der Punkte"
echo "========================="
echo ""


# konfig
FILENAME="punkte"
SUBDIR_BACKUP="backup/"

LOGIN_WEBSERVER="user@server"
PATH_WEBSERVER="/path/to/the/backup/"


# hilfsvariablen
FILENAME_ODS="${FILENAME}.ods"
FILENAME_PDF="${FILENAME}.pdf"
FILENAME_SVG="${FILENAME}.svg"

WEBSERVER="${LOGIN_WEBSERVER}:${PATH_WEBSERVER}"


# los geht's :-)
echo "1. Konvertiere odt -> pdf & svg"
echo "  a) libreoffice --headless --convert-to pdf ${FILENAME_ODS}"
sleep 2.0
libreoffice --headless --convert-to pdf "${FILENAME_ODS}"
echo "  b) pdf2svg ${FILENAME_PDF} ${FILENAME_SVG}"
sleep 2.0
pdf2svg "${FILENAME_PDF}" "${FILENAME_SVG}"


NOW="$(date +%Y_%m_%d_%H%M_)"
echo ""
echo "2. Erzeuge Backup (lokal)"
echo "  Datum & Uhrzeit: $NOW"
echo "  Ordner         : $SUBDIR_BACKUP"
mkdir -p "${SUBDIR_BACKUP}"

echo "  a) cp $FILENAME_ODS ..."
cp "$FILENAME_ODS" "${SUBDIR_BACKUP}${NOW}${FILENAME_ODS}"
echo "  b) cp $FILENAME_PDF ..."
cp "$FILENAME_PDF" "${SUBDIR_BACKUP}${NOW}${FILENAME_PDF}"
echo "  c) cp $FILENAME_PDF ..."
cp "$FILENAME_SVG" "${SUBDIR_BACKUP}${NOW}${FILENAME_SVG}"

echo ""
echo "3. Erzeuge Backup (online)"
echo "  Ordner         : $WEBSERVER"

echo "  a) scp $FILENAME_ODS ..."
scp "$FILENAME_ODS" "${WEBSERVER}${NOW}${FILENAME_ODS}"
echo "  b) scp $FILENAME_PDF ..."
scp "$FILENAME_PDF" "${WEBSERVER}${NOW}${FILENAME_PDF}"
echo "  c) scp $FILENAME_PDF ..."
scp "$FILENAME_SVG" "${WEBSERVER}${NOW}${FILENAME_SVG}"


echo ""
echo "3. Prüfe Ergebnis"
echo "  ristretto ${FILENAME_SVG}"
ristretto "${FILENAME_SVG}"
