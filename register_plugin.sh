#!/bin/bash

# cPanel Plugin Registration Script

# Check if the plugin is already registered
PLUGIN_NAME="SecuScan"
PLUGIN_DIR="/usr/local/cpanel/whostmgr/docroot/cgi/secuScan"
PLUGIN_CONF="/usr/local/cpanel/whostmgr/docroot/cgi/secuScan/plugin.conf"

# Register the plugin (make sure the plugin.conf exists)
if [ -f "$PLUGIN_CONF" ]; then
  echo "Registering plugin $PLUGIN_NAME..."
  # Create the symlink for WHM to recognize the plugin
  ln -s "$PLUGIN_DIR" "/usr/local/cpanel/whostmgr/docroot/cgi/$PLUGIN_NAME"
else
  echo "Plugin configuration file not found!"
  exit 1
fi
