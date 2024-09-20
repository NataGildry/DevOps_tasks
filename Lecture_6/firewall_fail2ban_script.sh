#!/bin/bash

ALLOW_IP=192.168.2.124  # IP address of the host
BLOCK_IP="203.0.113.42"  # IP to block from SSH

LOGFILE="/var/log/firewall_fail2ban_setup.log"

echo "Starting UFW and Fail2Ban setup..." | tee -a $LOGFILE
echo "Updating package list..." | tee -a $LOGFILE
if ! sudo apt-get update -y | tee -a $LOGFILE; then
  echo "Error: Failed to update package list." | tee -a $LOGFILE
  exit 1
fi

# Install UFW
echo "Installing UFW..." | tee -a $LOGFILE
if ! sudo apt-get install ufw -y | tee -a $LOGFILE; then
  echo "Error: Failed to install UFW." | tee -a $LOGFILE
  exit 1
fi

# Allow SSH access from host IP
echo "Allowing SSH access from $ALLOW_IP..." | tee -a $LOGFILE
if ! sudo ufw allow from $ALLOW_IP to any port 22 | tee -a $LOGFILE; then
  echo "Error: Failed to allow SSH access from $ALLOW_IP." | tee -a $LOGFILE
  exit 1
fi

# Deny SSH access from a specific IP
echo "Denying SSH access from $BLOCK_IP..." | tee -a $LOGFILE
if ! sudo ufw deny from $BLOCK_IP to any port 22 | tee -a $LOGFILE; then
  echo "Error: Failed to deny SSH access from $BLOCK_IP." | tee -a $LOGFILE
  exit 1
fi

# Enable UFW
echo "Enabling UFW..." | tee -a $LOGFILE
if ! sudo ufw --force enable | tee -a $LOGFILE; then
  echo "Error: Failed to enable UFW." | tee -a $LOGFILE
  exit 1
fi

# Check UFW status
echo "Checking UFW status..." | tee -a $LOGFILE
if ! sudo ufw status verbose | tee -a $LOGFILE; then
  echo "Error: Failed to retrieve UFW status." | tee -a $LOGFILE
  exit 1
fi

# Install Fail2Ban
echo "Installing Fail2Ban..." | tee -a $LOGFILE
if ! sudo apt-get install fail2ban -y | tee -a $LOGFILE; then
  echo "Error: Failed to install Fail2Ban." | tee -a $LOGFILE
  exit 1
fi

# Configure Fail2Ban for SSH protection
echo "Configuring Fail2Ban for SSH..." | tee -a $LOGFILE
sudo bash -c 'cat > /etc/fail2ban/jail.local <<EOF
[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
bantime = 3600
EOF' | tee -a $LOGFILE

# Restart Fail2Ban to apply configuration changes
echo "Restarting Fail2Ban service..." | tee -a $LOGFILE
if ! sudo systemctl restart fail2ban | tee -a $LOGFILE; then
  echo "Error: Failed to restart Fail2Ban service." | tee -a $LOGFILE
  exit 1
fi

# Check Fail2Ban status for SSH protection
echo "Checking Fail2Ban status for SSH..." | tee -a $LOGFILE
if ! sudo fail2ban-client status sshd | tee -a $LOGFILE; then
  echo "Error: Fail2Ban is not configured properly for SSH protection." | tee -a $LOGFILE
  exit 1
fi

echo "Disabling Fail2Ban to work with the machine..." | tee -a $LOGFILE
if ! sudo systemctl stop fail2ban | tee -a $LOGFILE; then
  echo "Error: Failed to stop Fail2Ban service." | tee -a $LOGFILE
  exit 1
fi

echo "Firewall and Fail2Ban setup completed successfully, Fail2Ban is now disabled for easier access." | tee -a $LOGFILE
