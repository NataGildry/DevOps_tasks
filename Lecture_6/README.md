# Server Setup and Configuration
This project provides a step-by-step guide to set up an Nginx web server, configure a custom systemd service, secure your server with UFW and Fail2Ban, and handle disk partitioning and mounting. 

## Prerequisites

Before starting, make sure you have the following:
- [Vagrant](https://www.vagrantup.com/downloads)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Ubuntu-based Linux distribution.
- Sudo/root access to install and configure software.

## Setup Instructions

1. Clone this repository to your local machine.
    ```bash
    git clone https://github.com/NataGildry/DevOps_tasks.git
    cd DevOps_tasks/Lecture_6
    ```

2. Ensure the shared folder path on your host machine is correctly set in the `Vagrantfile`.

3. Run the following command to start the virtual machine:
    ``` bash
     vagrant up --provider=virtualbox
    ```

4. After the VM is up and running, you can SSH into the VM using:
    ``` bash
     vagrant ssh
    ```

## Steps Overview

1. **Install and Configure Nginx from Official Repository**
2. **Add Nginx PPA Repository**
3. **Remove the PPA and revert to the official version**
4. **Create a Custom Systemd Service**
5. **Set Up UFW (Uncomplicated Firewall)**
6. **Configure Fail2Ban for SSH Protection**
7. **Create and Mount a New Disk Partition**

---

### 1. Install and Configure Nginx from Official Repository
 _Screenshot 1: Nginx web server installed from the official repo._
 ![alt text](image.png)

 ### 2. Add Nginx PPA Repository
 _Screenshot 2: Nginx PPA repository added successfully._
![alt text](image-1.png)

 ### 3. Remove the PPA and revert to the official version
 _Screenshot 3: Nginx reverted to the official version successfully._
![alt text](image-2.png)

 ### 4. Create a Custom Systemd Service

Run the following command to check the log file:

    ``` bash 
     cat /var/log/my_script.log
    ```

  _Screenshot 4: Time logs from the Custom Systemd Service ._
![alt text](image-5.png)

 ### 5. Set Up UFW (Uncomplicated Firewall)

  _Screenshot 5: UFW is running ._
![alt text](image-4.png)

 ### 7. Create and Mount a New Disk Partition

 After the VM is up, SSH into it and check if the partition is mounted:

    ``` bash 
     df -h
    ```

  _Screenshot 6: **/dev/sdb1:** the new partition is mounted ._
![alt text](image-6.png)

Made with 🤍 by Nataliia 
---