echo "Config - Copy Configuration of Plist file to the project"
CONFIGURATION_LOWER=$(echo "$CONFIGURATION" | tr '[:upper:]' '[:lower:]')
CLIENT_RESOURCE_PATH="$SRCROOT/ClientsData/$CLIENT_PATH/plist_values.$CONFIGURATION_LOWER.xcconfig"
DESTINATION_ASSETS_PATH="$SRCROOT/ConfigFiles/Config.$CONFIGURATION_LOWER.xcconfig"
echo $DESTINATION_ASSETS_PATH
if [ -d "$DESTINATION_ASSETS_PATH" ]; then
    echo "Deleting existing Config.production.xcconfig folder at: $DESTINATION_ASSETS_PATH"
    rm -rf "$DESTINATION_ASSETS_PATH"
fi
cp -R "$CLIENT_RESOURCE_PATH" "$DESTINATION_ASSETS_PATH"
echo "End Config, Config Plist copied to the project -----------------"

