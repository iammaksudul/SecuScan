#!/bin/bash

# Install Script for cPanel SecuScan Plugin

echo "Installing SecuScan Plugin..."

# Step 1: Create the plugin directory in the correct location
mkdir -p /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/

# Step 2: Copy the plugin files to the appropriate directory
cp /root/SecuScan/secuScan.sh /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/
cp /root/SecuScan/index.html /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/

# Step 3: Create the plugin configuration file (plugin.conf)
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

# Step 4: Set the correct permissions for the plugin directory and scripts
chmod -R 755 /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/
chmod +x /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/secuScan.sh

# Step 5: Register the plugin with cPanel using the register_plugin.sh script
# Ensure register_plugin.sh is in the correct directory
if [ -f /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/register_plugin.sh ]; then
  echo "Registering the SecuScan plugin with cPanel..."
  /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/register_plugin.sh
else
  echo "register_plugin.sh script not found. Please ensure it exists and is in the correct directory."
  exit 1
fi

# Step 6: Restart cPanel service
echo "Restarting cPanel service to apply changes..."
systemctl restart cpanel.service

# Step 7: Installation complete
echo "Installation completed. Access your plugin from WHM under the Plugins section!"
