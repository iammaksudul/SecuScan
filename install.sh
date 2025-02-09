#!/bin/bash

# Install Script for cPanel SecuScan Plugin

echo "Installing SecuScan Plugin..."

# Create the plugin directory in the correct location
mkdir -p /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/

# Copy the correct script files from the current directory
cp /root/cpanel-compromise-detection-plugin/secuScan.sh /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/
cp /root/cpanel-compromise-detection-plugin/index.html /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/

# Create the cPanel configuration file for the plugin (plugin.conf)
cat > /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/plugin.conf << EOF
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
chmod -R 755 /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/
chmod +x /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/secuScan.sh

# Register the plugin in WHM (optional step, make sure your plugin is registered correctly in WHM)
# You can register it as part of the cPanel system to make it appear under the "Plugins" section
/usr/local/cpanel/scripts/register_plugin --name="SecuScan" --category="Security" --path="/usr/local/cpanel/whostmgr/docroot/cgi/secuScan/"

# Finish the installation process
echo "Installation completed. Access your plugin from WHM under the Plugins section!"
