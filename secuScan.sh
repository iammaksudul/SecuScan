#!/bin/bash

# Define log paths
LOGS_DIR="/usr/local/apache/domlogs/"
SECURE_LOG="/var/log/secure"
HTACCESS_DIR="/home/$USER/public_html/.htaccess"
EMAIL="admin@example.com"
BACKUP_DIR="/backups/"

# Scan Apache Logs for suspicious POST and eval usage
echo "Scanning Apache logs for suspicious activity..."
for USER in $(ls /var/cpanel/users/); do
    ACCESS_LOG="${LOGS_DIR}${USER}"
    if [ -f "$ACCESS_LOG" ]; then
        echo "Checking Apache access logs for $USER..."
        suspicious_post=$(grep -i "POST" "$ACCESS_LOG")
        suspicious_eval=$(grep -i "eval(" "$ACCESS_LOG")
        if [ ! -z "$suspicious_post" ] || [ ! -z "$suspicious_eval" ]; then
            echo "Suspicious activity detected in Apache logs for $USER" >> /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/scan_results.log
            compromised=true
        fi
    fi
done

# Scan .htaccess files for suspicious redirects or php_value
for USER in $(ls /var/cpanel/users/); do
    HTACCESS_FILE="/home/$USER/public_html/.htaccess"
    if [ -f "$HTACCESS_FILE" ]; then
        suspicious_redirects=$(grep -i "Redirect" "$HTACCESS_FILE")
        suspicious_php_value=$(grep -i "php_value" "$HTACCESS_FILE")
        if [ ! -z "$suspicious_redirects" ] || [ ! -z "$suspicious_php_value" ]; then
            echo "Suspicious entries found in .htaccess for $USER" >> /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/scan_results.log
            compromised=true
        fi
    fi
done

# SSH Log Analysis
echo "Checking for failed SSH login attempts..."
unauthorized_ssh=$(grep "Failed password" "$SECURE_LOG")
if [ ! -z "$unauthorized_ssh" ]; then
    echo "Unauthorized SSH access attempts detected." >> /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/scan_results.log
    compromised=true
fi

# Check for file integrity and suspicious files
for USER in $(ls /var/cpanel/users/); do
    PUBLIC_HTML_DIR="/home/$USER/public_html"
    if [ -d "$PUBLIC_HTML_DIR" ]; then
        echo "Scanning public_html for suspicious files..."
        suspicious_files=$(find "$PUBLIC_HTML_DIR" -type f -exec grep -l "eval(" {} \;)
        if [ ! -z "$suspicious_files" ]; then
            echo "Suspicious files found in $USER's public_html" >> /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/scan_results.log
            compromised=true
        fi
    fi
done

# Automatic suspensions for compromised accounts
if [ "$compromised" == true ]; then
    for USER in $(ls /var/cpanel/users/); do
        /scripts/suspendacct "$USER"
        echo "Account $USER has been suspended due to suspicious activity." >> /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/scan_results.log
    done
fi

# Email alert for compromised accounts
if [ "$compromised" == true ]; then
    mail -s "Compromised accounts detected" "$EMAIL" < /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/scan_results.log
    echo "Email alert sent to admin." >> /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/scan_results.log
fi

# Set suspicious file permissions to prevent modification
for USER in $(ls /var/cpanel/users/); do
    find /home/$USER/public_html/ -type f -exec chmod 444 {} \;
    echo "Suspicious files in $USER's public_html have been locked down with read-only permissions." >> /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/scan_results.log
done

# Log activity and actions taken
echo "$(date) - Scan Completed" >> /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/scan_activity.log
