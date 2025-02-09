#!/bin/bash

# This script is used to manually register a cPanel plugin

PLUGIN_NAME="SecuScan"
PLUGIN_DIR="/usr/local/cpanel/whostmgr/docroot/cgi/secuScan"

# Create the plugin directory
mkdir -p $PLUGIN_DIR

# Copy the plugin files to the proper location
cp /root/SecuScan/secuScan.sh $PLUGIN_DIR/
cp /root/SecuScan/index.html $PLUGIN_DIR/

# Create a configuration file for the plugin
cat > $PLUGIN_DIR/plugin.conf << EOF
PLUGIN_NAME="SecuScan"
PLUGIN_AUTHOR="Kh Maksudul Alam"
PLUGIN_DESCRIPTION="Detects potential signs of compromise for cPanel users."
PLUGIN_VERSION="1.0"
PLUGIN_LICENSE="MIT License"
PLUGIN_WEBSITE="https://www.maksudulalam.com/"

# Optional Configurations
PLUGIN_ENABLE_EMAIL_ALERTS="true"
PLUGIN_ALERT_EMAIL="admin@example.com"
EOF

# Set appropriate permissions
chmod -R 755 $PLUGIN_DIR
chmod +x $PLUGIN_DIR/secuScan.sh

# Restart cPanel for the plugin to be recognized
service cpanel restart

echo "SecuScan Plugin has been registered successfully!"
