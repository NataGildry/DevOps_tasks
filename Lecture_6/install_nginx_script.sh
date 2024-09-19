#!/bin/bash

LOGFILE="/var/log/nginx_install.log"
echo "Updating package list..." | tee -a $LOGFILE
sudo apt-get update | tee -a $LOGFILE
  
echo "Installing Nginx from the official repository..." | tee -a $LOGFILE
sudo apt-get install -y nginx | tee -a $LOGFILE
  
echo "Checking Nginx installation source..." | tee -a $LOGFILE
 apt-cache policy nginx | tee -a $LOGFILE
  
echo "Adding PPA repository for Nginx..." | tee -a $LOGFILE
sudo add-apt-repository -y ppa:nginx/stable | tee -a $LOGFILE
sudo apt-get update | tee -a $LOGFILE
  
echo "Installing Nginx from PPA if available..." | tee -a $LOGFILE
sudo apt-get install -y nginx | tee -a $LOGFILE
  
echo "Checking Nginx installation source after PPA installation..." | tee -a $LOGFILE
apt-cache policy nginx | tee -a $LOGFILE
  
echo "Reverting to the official version of Nginx using ppa-purge..." | tee -a $LOGFILE
sudo apt-get install -y ppa-purge | tee -a $LOGFILE

sudo ppa-purge -y ppa:nginx/stable | tee -a $LOGFILE
sudo apt-get update | tee -a $LOGFILE
  
echo "Starting Nginx..." | tee -a $LOGFILE
sudo systemctl start nginx | tee -a $LOGFILE
  
echo "Checking Nginx status..." | tee -a $LOGFILE
sudo systemctl status nginx | tee -a $LOGFILE
  
echo "Script execution completed!" | tee -a $LOGFILE