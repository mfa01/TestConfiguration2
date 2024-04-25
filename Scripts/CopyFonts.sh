echo "CONFIG - Running script to copy+add fonts ----"
FONTS_DIR="${SRCROOT}/ClientsData/$CLIENT_PATH/Fonts"
DEST_DIR="${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
INFO_PLIST="$SRCROOT/$PROJECT_NAME/info.plist"
/usr/libexec/PlistBuddy -c "Delete :UIAppFonts" "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Add :UIAppFonts array" "$INFO_PLIST"
for fontFile in "${FONTS_DIR}"/*.ttf "${FONTS_DIR}"/*.otf; do
    echo "fontFile: $fontFile"
    if [ -f "$fontFile" ]; then
        cp "$fontFile" "${DEST_DIR}/"
        # Update Info.plist with font file entry
        /usr/libexec/PlistBuddy -c "Add :UIAppFonts:0 string $(basename "$fontFile")" "$INFO_PLIST"
        echo "Added font entry to Info.plist: $(basename "$fontFile")"
    fi
done
