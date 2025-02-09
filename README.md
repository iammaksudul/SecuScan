

# SecuScan - cPanel Compromise Detection Plugin

SecuScan is a powerful cPanel plugin designed to detect suspicious activity, such as compromised files, failed login attempts, and other hacking attempts. It offers real-time scanning, logging, and email alerts for system administrators to help secure their cPanel servers.

## Features
- **Apache Log Scan**: Detect suspicious POST requests and `eval()` usage.
- **Suspicious File Detection**: Look for compromised files in `public_html` directories.
- **SSH Log Analysis**: Identify failed SSH login attempts.
- **Cron Jobs and .htaccess Monitoring**: Detect unauthorized modifications.
- **Email Alerts**: Receive email notifications when compromised accounts are detected.
- **Logging**: View detailed logs for all detected activities.
- **Manual Account Suspension**: Admins can manually suspend compromised accounts to mitigate threats immediately.

## Installation

### 1. Clone the repository to your server:
First, ensure you have SSH access to your server with root privileges.

```bash
git clone https://github.com/iammaksudul/SecuScan.git
cd SecuScan
```

### 2. Run the installation script:
Once you have the repository cloned, make sure the script is executable and run the installation script to set up the plugin on your cPanel/WHM server.

```bash
chmod +x install.sh
sudo ./install.sh
```

### 3. Install the plugin:
The installation script will copy all necessary files (scripts, configuration, etc.) to the appropriate directories on your cPanel server. After successful installation, SecuScan will be available under the **Plugins** section in WHM.

---

## Configuration

After installation, you can configure **SecuScan** by editing the configuration files to suit your server's needs. 

### 1. Plugin Configuration (plugin.conf):
You can configure email alerts and other settings by modifying the `plugin.conf` file located in `/usr/local/cpanel/whostmgr/docroot/cgi/secuScan/plugin.conf`.

**Example:**

```bash
PLUGIN_NAME="SecuScan"
PLUGIN_AUTHOR="Kh Maksudul Alam"
PLUGIN_DESCRIPTION="Detects potential signs of compromise for cPanel users."
PLUGIN_VERSION="1.0"
PLUGIN_LICENSE="MIT License"
PLUGIN_WEBSITE="https://www.maksudulalam.com/"

# Optional Configurations
PLUGIN_ENABLE_EMAIL_ALERTS="true"
PLUGIN_ALERT_EMAIL="admin@example.com"  # Change this to your desired email address
```

To change the alert email or disable email alerts:

1. Open the `plugin.conf` file:

   ```bash
   sudo nano /usr/local/cpanel/whostmgr/docroot/cgi/secuScan/plugin.conf
   ```

2. Modify the following lines:
   
   - **PLUGIN_ENABLE_EMAIL_ALERTS="true"**: Set this to `false` if you don’t want to receive email alerts.
   - **PLUGIN_ALERT_EMAIL="admin@example.com"**: Replace with your email address for receiving alerts.

### 2. Email Configuration:
If email alerts are enabled, make sure your server is correctly configured to send emails. The plugin uses `mail` to send email alerts. To test the email functionality, you can send a test email from the server:

```bash
echo "Test email from SecuScan" | mail -s "SecuScan Test" admin@example.com
```

Replace `admin@example.com` with your actual email to verify that emails are being sent correctly.

---

## Using SecuScan

### 1. Access the Plugin in WHM:
After installation, you can access SecuScan from the **Plugins** section of WHM. There, you'll find options to:

- **Start a Scan**: Trigger the plugin to scan for suspicious activity across all cPanel accounts.
- **View Logs**: Access detailed logs of detected activities.
- **Manage Alerts**: Configure email notifications for security alerts.

### 2. Manual Account Suspension:
If SecuScan detects a compromised account, it will notify the system administrator. You can then manually suspend the compromised account from the **Account Functions** section of WHM.

- Go to **Account Functions** -> **Suspend/Unsuspend an Account**.
- Search for the compromised account and suspend it.

---

## Uninstallation

To uninstall **SecuScan** from your cPanel/WHM server, you can run the uninstallation script:

```bash
sudo bash uninstall.sh
```

This will remove all files associated with the plugin from the server.

---

## License

SecuScan is licensed under the [MIT License](https://opensource.org/licenses/MIT). You can freely modify and distribute the plugin.

---

If you need further assistance, feel free to reach out on the [SecuScan GitHub repository](https://github.com/iammaksudul/SecuScan).

