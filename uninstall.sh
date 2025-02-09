#!/bin/bash

# Uninstall script for SecuScan Plugin

echo "Uninstalling SecuScan Plugin..."

# Remove files
rm -rf /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/

# Remove cron job
rm -f /etc/cron.d/secuScan

echo "SecuScan Plugin uninstalled successfully!"
