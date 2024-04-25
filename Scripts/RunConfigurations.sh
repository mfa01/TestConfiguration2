# Copy config files to project, this needed to allow plist take automatic values from PLIST config
source "$SRCROOT/Scripts/CopyConfigurationPLISTFile.sh"
# Add needed vars to plist
source "$SRCROOT/Scripts/AddConfigurationToPLIST.sh"

# Copy Images
source "$SRCROOT/Scripts/CopyAssets.sh"

# Copy client fonts and add them to plist
source "$SRCROOT/Scripts/CopyFonts.sh"

# Generate Config swift file from configurations
source "$SRCROOT/Scripts/GenerateConfigurationVarsSwiftFile.sh"

# Add AssociatedDomains used for dynamic links
source "$SRCROOT/Scripts/AddAssociatedDomains.sh"
