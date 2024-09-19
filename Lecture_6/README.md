# Server Setup and Configuration
This project provides a step-by-step guide to set up an Nginx web server, configure a custom systemd service, secure your server with UFW and Fail2Ban, and handle disk partitioning and mounting. 

## Prerequisites

Before starting, make sure you have the following:
- Ubuntu/Debian-based Linux distribution.
- Sudo/root access to install and configure software.
- Basic knowledge of terminal commands.

## Steps Overview

1. **Install and Configure Nginx from Official Repository**
2. **Add and Remove Nginx PPA Repository**
3. **Create a Custom Systemd Service**
4. **Set Up UFW (Uncomplicated Firewall)**
5. **Configure Fail2Ban for SSH Protection**
6. **Create and Mount a New Disk Partition**

---

### 1. Install and Configure Nginx from Official Repository

Install and configure the Nginx web server:

```bash
sudo apt update
sudo apt install nginx
 ```

 _Screenshot 1: Nginx web server installed and running._

 ### 2. Add and Remove Nginx PPA Repository

Switch to a PPA repository for Nginx:

```bash
sudo apt install software-properties-common
sudo add-apt-repository ppa:nginx/stable
sudo apt update
 ```

 _Screenshot 2: Nginx PPA repository added successfully._


 Remove the PPA and revert to the official version:

```bash
sudo apt install ppa-purge
sudo ppa-purge ppa:nginx/stable
 ```


## Conclusion


Made with 🤍 by Nataliia 
---