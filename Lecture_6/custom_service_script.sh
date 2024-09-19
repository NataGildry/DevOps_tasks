#!/bin/bash

echo "Creating systemd service and timer..." | tee -a /var/log/provision.log
      
# Create directory for the script
sudo mkdir -p /usr/local/bin/my_script

# Logging script
echo '#!/bin/bash' | sudo tee /usr/local/bin/my_script/log_time.sh
echo 'echo "Current date and time: $(date)" >> /var/log/my_script.log' | sudo tee -a /usr/local/bin/my_script/log_time.sh

# Make the script executable
sudo chmod +x /usr/local/bin/my_script/log_time.sh

# Systemd service file
echo '[Unit]' | sudo tee /etc/systemd/system/log_time.service
echo 'Description=Log current date and time every minute' | sudo tee -a /etc/systemd/system/log_time.service
echo '[Service]' | sudo tee -a /etc/systemd/system/log_time.service
echo 'Type=simple' | sudo tee -a /etc/systemd/system/log_time.service
echo 'ExecStart=/usr/local/bin/my_script/log_time.sh' | sudo tee -a /etc/systemd/system/log_time.service
echo 'User=root' | sudo tee -a /etc/systemd/system/log_time.service
echo '[Install]' | sudo tee -a /etc/systemd/system/log_time.service
echo 'WantedBy=multi-user.target' | sudo tee -a /etc/systemd/system/log_time.service

# Systemd timer file
echo '[Unit]' | sudo tee /etc/systemd/system/log_time.timer
echo 'Description=Timer for log_time service' | sudo tee -a /etc/systemd/system/log_time.timer
echo '[Timer]' | sudo tee -a /etc/systemd/system/log_time.timer
echo 'OnActiveSec=1min' | sudo tee -a /etc/systemd/system/log_time.timer
echo 'OnUnitActiveSec=1min' | sudo tee -a /etc/systemd/system/log_time.timer
echo 'Unit=log_time.service' | sudo tee -a /etc/systemd/system/log_time.timer
echo '[Install]' | sudo tee -a /etc/systemd/system/log_time.timer
echo 'WantedBy=timers.target' | sudo tee -a /etc/systemd/system/log_time.timer

# Enable and start the timer
sudo systemctl enable log_time.timer
sudo systemctl start log_time.timer