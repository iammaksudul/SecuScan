# SecuScan - cPanel Compromise Detection Plugin

SecuScan is a powerful cPanel plugin designed to detect suspicious activity, such as compromised files, failed login attempts, and other hacking attempts. It offers real-time scanning, logging, and email alerts for system administrators.

## Features
- **Apache Log Scan**: Detect suspicious POST requests and eval() usage.
- **Suspicious File Detection**: Look for compromised files in `public_html` directories.
- **SSH Log Analysis**: Look for failed SSH login attempts.
- **Cron Jobs and .htaccess Monitoring**: Detect unauthorized modifications.
- **Email Alerts**: Receive email notifications when compromised accounts are detected.
- **Logging**: View detailed logs for all detected activities.
- **Manual Account Suspension**: Admin can suspend compromised accounts.

## Installation
1. Clone the repository to your server:
   ```bash
   git clone https://github.com/iammaksudul/SecuScan.git
   cd SecuScan
