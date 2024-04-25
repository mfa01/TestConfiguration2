# Path to the xcconfig file and generated Swift file
CONFIG_FILE="${SRCROOT}/ClientsData/$CLIENT_PATH/configurations.xcconfig"
GENERATED_FILE="${SRCROOT}/Generated/ConfigValues.swift"

# Read the values from the xcconfig file and append them to the generated Swift file
echo "Generating ConfigValues.swift..."
echo "import Foundation" > "$GENERATED_FILE"
echo "" >> "$GENERATED_FILE"
echo "class ConfigValues {" >> "$GENERATED_FILE"
echo "    static let shared = ConfigValues()" >> "$GENERATED_FILE"
echo "" >> "$GENERATED_FILE"

# Read the content of the xcconfig file and add key-value pairs to the Swift file
while IFS='=' read -r key value; do
    # Remove leading and trailing whitespace from the key and value
    key=$(echo $key | tr -d '[:space:]')
    value=$(echo $value | tr -d '[:space:]')
    
    # Check if the key starts with "//" and skip adding it if true
    if [[ "$key" == "//"* ]] || [[ "$key" == "#include"* ]] || [[ "$key" == "" ]]; then
        echo "Skipping key starting with //: $key"
    else
        echo "    let $key = \"$value\"" >> "$GENERATED_FILE"
    fi
done < "$CONFIG_FILE"

echo "" >> "$GENERATED_FILE"
echo "    private init() {}" >> "$GENERATED_FILE"
echo "}" >> "$GENERATED_FILE"

echo "ConfigValues.swift generated successfully.#############"
