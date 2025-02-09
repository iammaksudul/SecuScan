#!/bin/bash

# Install Script for cPanel SecuScan Plugin

echo "Installing SecuScan Plugin..."

# Create the plugin directory in the correct location
PLUGIN_DIR="/usr/local/cpanel/whostmgr/docroot/cgi/secuScan/"
mkdir -p $PLUGIN_DIR

# Copy the correct script files from the current directory
cp /root/SecuScan/secuScan.sh $PLUGIN_DIR
cp /root/SecuScan/index.html $PLUGIN_DIR

# Create the cPanel configuration file for the plugin (plugin.conf)
cat > $PLUGIN_DIR/plugin.conf << EOF
# Plugin Configuration for SecuScan
name=SecuScan
category=Security
author=Kh Maksudul Alam
description=SecuScan is a powerful cPanel plugin that scans for suspicious activities like compromised files, failed logins, and hacking attempts.
version=1.0
license=MIT License
url=https://www.maksudulalam.com/

# Optional Configurations
enable_email_alerts=true
alert_email="admin@example.com"  # Change this to your desired email address
EOF

# Set the appropriate permissions for the plugin directory and scripts
chmod -R 755 $PLUGIN_DIR
chmod +x $PLUGIN_DIR/secuScan.sh

# Register the plugin in WHM (Ensure the plugin is correctly registered in WHM)
# Adding the plugin registration details
if [ -f /usr/local/cpanel/scripts/register_plugin ]; then
  /usr/local/cpanel/scripts/register_plugin --name="SecuScan" --category="Security" --path="$PLUGIN_DIR"
else
  echo "register_plugin script not found. Please ensure cPanel is properly configured."
fi

# Restart cPanel service to register the plugin
service cpanel restart

# Finish the installation process
echo "Installation completed. Access your plugin from WHM under the Plugins section!"
