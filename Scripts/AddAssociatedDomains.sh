echo "Config - entitlements"
CONFIGURATION_LOWER=$(echo "$CONFIGURATION" | tr '[:upper:]' '[:lower:]')
CONFIG_FILE="$SRCROOT/ClientsData/$CLIENT_PATH/plist_values.$CONFIGURATION_LOWER.xcconfig"
INFO_PLIST="$SRCROOT/$PROJECT_NAME/info.plist"
ENTITLEMENTS_FILE="$SRCROOT/Entitlements/$CONFIGURATION_LOWER.entitlements"

AssociatedDomains=$(grep -Eo "AssociatedDomains\s*=\s*\[([^]]+)" "$CONFIG_FILE" | cut -d'[' -f2- | tr -d '[:space:]' | tr -d '[' | tr -d ']' | tr ',' '\n')
# Add associated domains to the entitlements file
/usr/libexec/PlistBuddy -c "Delete :com.apple.developer.associated-domains array" "$ENTITLEMENTS_FILE" >/dev/null 2>&1
/usr/libexec/PlistBuddy -c "Add :com.apple.developer.associated-domains array" "$ENTITLEMENTS_FILE" >/dev/null 2>&1

for domain in $AssociatedDomains; do
    /usr/libexec/PlistBuddy -c "Add :com.apple.developer.associated-domains:0 string $domain" "$ENTITLEMENTS_FILE" >/dev/null 2>&1
done

echo "End Config - entitlements"
