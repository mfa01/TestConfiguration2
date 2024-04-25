echo "Add PLIST values"

CONFIGURATION_LOWER=$(echo "$CONFIGURATION" | tr '[:upper:]' '[:lower:]')
CONFIG_FILE="$SRCROOT/ClientsData/$CLIENT_PATH/plist_values.$CONFIGURATION_LOWER.xcconfig"
INFO_PLIST="$SRCROOT/$PROJECT_NAME/info.plist"

echo "CONFIG_FILE - $CONFIG_FILE"
echo "INFO_PLIST - $INFO_PLIST"


# Extract the values from the config file
CFBundleURLName=$(grep -Eo "BundleURLName\s*=\s*([^;]+)" "$CONFIG_FILE" | cut -d'=' -f2 | tr -d '[:space:]')
BundleUrlSchemes=$(grep -Eo "BundleUrlSchemes\s*=\s*\[([^]]+)" "$CONFIG_FILE" | cut -d'[' -f2- | tr -d '[:space:]' | tr -d '[' | tr -d ']' | tr ',' '\n')

# Read the xcconfig file and extract key-value pairs
while IFS='=' read -r key value
do
    # Remove leading and trailing whitespace from the key and value
    key=$(echo $key | tr -d '[:space:]')
    value=$(echo $value | tr -d '[:space:]')
    # Set the environment variable using the key and value, but this was not working so we adding it to info plist
    #export $key="$value"
    # Check if the key starts with "//" and skip adding it if true
    if [[ "$key" == "//"* ]] || [[ "$key" == "#include"* ]] || [[ "$key" == "" ]]; then
        echo "Skipping key starting with //: $key"
    else
        # Check if the value is an array in the format [value1,value2]
        if [[ $value =~ ^\[.*\]$ ]]; then
            # Remove square brackets and split values into an array
            value=$(echo $value | tr -d '[]' | tr ',' '\n')
            # Add each value from the array to Info.plist as a string
            /usr/libexec/PlistBuddy -c "Delete $key" "$INFO_PLIST"
            while IFS= read -r array_value; do
                echo "Adding array value to key: $key, value: $array_value"
                /usr/libexec/PlistBuddy -c "Add :$key array" "$INFO_PLIST"
                /usr/libexec/PlistBuddy -c "Add :$key:0 string ${array_value}" "$INFO_PLIST"
            done <<< "$value"
        elif [[ "$key" == "CFBundleURLTypes" ]]; then
            /usr/libexec/PlistBuddy -c "Delete $key" "$INFO_PLIST"
            # Add CFBundleURLTypes key as an array
            /usr/libexec/PlistBuddy -c "Add :$key array" "$INFO_PLIST" >/dev/null 2>&1
            # Add dictionary structure to the CFBundleURLTypes array
            /usr/libexec/PlistBuddy -c "Add :$key:0 dict" "$INFO_PLIST" >/dev/null 2>&1
            # Add CFBundleTypeRole key to the dictionary
            /usr/libexec/PlistBuddy -c "Add :$key:0:CFBundleTypeRole string Editor" "$INFO_PLIST" >/dev/null 2>&1
            /usr/libexec/PlistBuddy -c "Add :$key:0:CFBundleURLName string $CFBundleURLName" "$INFO_PLIST" >/dev/null 2>&1
            # Add CFBundleURLSchemes key as an array to the dictionary
            /usr/libexec/PlistBuddy -c "Add :$key:0:CFBundleURLSchemes array" "$INFO_PLIST" >/dev/null 2>&1
            # Add string values to the CFBundleURLSchemes array
            for scheme in $BundleUrlSchemes; do
                /usr/libexec/PlistBuddy -c "Add :$key:0:CFBundleURLSchemes:0 string $scheme" "$INFO_PLIST" >/dev/null 2>&1
            done
        else
            echo "Setting environment variable key: $key and value: $value"
            /usr/libexec/PlistBuddy -c "Delete $key" "$INFO_PLIST"
            /usr/libexec/PlistBuddy -c "Add :$key string $value" "$INFO_PLIST"
        fi
    fi
done < "$CONFIG_FILE"

echo "Pre script CONFIG - End ------------"
