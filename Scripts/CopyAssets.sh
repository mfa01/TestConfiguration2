echo "Pre CONFIG - Adding assets to the project"

CLIENT_RESOURCE_PATH="$SRCROOT/ClientsData/$CLIENT_PATH/Assets.xcassets"
DESTINATION_ASSETS_PATH="$SRCROOT/$PROJECT_NAME/Assets.xcassets"

if [ -d "$DESTINATION_ASSETS_PATH" ]; then
    echo "Deleting existing Assets.xcassets folder at: $DESTINATION_ASSETS_PATH"
    rm -rf "$DESTINATION_ASSETS_PATH"
fi
cp -R "$CLIENT_RESOURCE_PATH" "$DESTINATION_ASSETS_PATH"
echo "End Pre script, Assets copied to the project assets path -----------------"


