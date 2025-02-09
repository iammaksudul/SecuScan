#!/bin/bash

# Uninstall Script for cPanel Compromise Detection Plugin

echo "Uninstalling cPanel Compromise Detection Plugin..."

# Remove plugin directory and files
rm -rf /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/

echo "Uninstallation completed."
