# Configure_AWS_Instance_for_Udacity_Self_Driving_Car_Engineer_Nanodegree
Configure AWS instance for Udacity Self-Driving Car Engineer Nanodegree step by step.

# Warning: this repository needs more updates to complete and should be ready soon.  
# This repository is refer to [ec2-setup](https://github.com/yrahal/ec2-setup).
# I simplified the steps and put some comments for understanding.


## Overview
___
This tutorial is prepared for the final project in term 3 of Udacity Self-Driving Engineering Nanodegree. In this tutorial,
you will learn how to setup a AWS EC2 instance from existing AMI and install the Lubuntu desktop.(https://lubuntu.net/)
Then you will use VNC reviewer to connect to the Lubuntu desktop from Windows 7 or 10.  
## Tools
___
* [PuTTY](https://www.putty.org/)  
* [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/)  
## Steps
___
### Create Instance in AWS EC2
+ Launch AWS Instances  
![Image Placeholder](url)
+ Choose AMI (Search for udacity-carnd-advanced-deep-learning)  
![Image Placeholder](url)
+ Select g2 or g3 for your compute  
![Image Placeholder](url)
+ Configure Instance Details  
![Image Placeholder](url)
+ Add storage  
![Image Placeholder](url)
+ Add tags  
![Image Placeholder](url)
+ Configure security group  
Make sure you have port 5901 opened for VNC viewer connection purpose.  
![Image Placeholder](url)
+ Review instance and launch  
![Image Placeholder](url)
+ Select key pair  
![Image Placeholder](url)
+ Configure setup finished  
![Image Placeholder](url)
+ Instance console  
![Image Placeholder](url)
+ Done  
### Install Lubuntu
+ Connect to your AWS EC2 server with PuTTY  
![Image Placeholder](url)
+ Setup your password  
`sudo passwd`
In this tutorial, I will be using “taco123” as my password  
![Image Placeholder](url)
+ Login as superuser  
`su`  
![Image Placeholder](url)
+ Updates the package lists for upgrades for packages that need upgrading  
`sudo apt-get update`  
![Image Placeholder](url)
+ Install Lubuntu desktop  
`sudo apt-get install lubuntu-desktop`  
![Image Placeholder](url)
+ Press 'Y' then 'Enter' to continue  
![Image Placeholder](url)
+ Exit Superuser mode  
`exit`  
![Image Placeholder](url)
+ Done  
### Install tightVNC
+ Install VNC server  
`apt-get install tightvncserver`  
![Image Placeholder](url)
+ Initial VNC server  
`tightvncserver :1`  
![Image Placeholder](url)
+ Stop VNC server  
`tightvncserver -kill :1`  
![Image Placeholder](url)
+ Open startup script just created  
`vim ~/.vnc/xstartup`  
![Image Placeholder](url)
+ Open and add following text in the file and save it  
```
{
lxterminal &
/usr/bin/lxsession -s Lubuntu &
}
````  
![Image Placeholder](url)
+ Reboot your Ubuntu server  
`sudo reboot`  
![Image Placeholder](url)
+ Done  
### Launch and connect
+ Download your VNC viewer  
![Image Placeholder](url)
+ Reconnect to the AWS EC2 instance with PuTTY again after rebooting your Ubuntu server  
+ Launch VNC server  
`tightvncserver :1`  
![Image Placeholder](url)
+ Launch your VNC from Windows  
![Image Placeholder](url)
+ Copy IPv4 address from AWS EC2 Instance  
![Image Placeholder](url)
+ Paste in VNC viewer console and add desktop number (ex. 34.201.160.255:1)  
![Image Placeholder](url)
+ Continue to warning message  
![Image Placeholder](url)
+ Enter password  
![Image Placeholder](url)
+ Congratulations! You are good to go!  
![Image Placeholder](url)
+ Done  
### Disconnect and exit
+ Close your VNC viewer from Windows  
+ Close your VNC server in PuTTY  
`tightvncserver -kill :1`  
![Image Placeholder](url)
+ Exit PuTTY  
+ Stop AWS EC2 Instance  
+ Done  
## Conclusions
___
## Tips
___
You could save more money by using spot instance or reserved instance.  
## References
___
* [ec2-setup](https://github.com/yrahal/ec2-setup)
* [What does “sudo apt-get update” do?](https://askubuntu.com/questions/222348/what-does-sudo-apt-getupdate-do)  
* [Will apt-get dist-upgrade upgrade my system to newer version? [duplicate]](https://askubuntu.com/questions/215267/will-apt-get-dist-upgrade-upgrade-my-system-to-newerversion/215268)  
* [What is “dist-upgrade” and why does it upgrade more than “upgrade”?](https://askubuntu.com/questions/81585/what-is-dist-upgrade-and-why-does-it-upgrade-more-thanupgrade)  
* [How To Set Up GUI On Amazon EC2 Ubuntu server.Ubuntu desktop and connect to it from Windows.](https://www.youtube.com/watch?v=oqUNkF8WoU4)  
* [Which Official Ubuntu Flavor Is Best for You?](https://www.linux.com/learn/intro-to-linux/2017/5/whichofficial-ubuntu-flavor-best-you)  
* [How do you run Ubuntu Server with a GUI?](https://askubuntu.com/questions/53822/how-do-you-runubuntu-server-with-a-gui)  
* [Ubuntu flavours](https://www.ubuntu.com/download/flavours)  
* [LXDE](https://lxde.org/)  
* [Installing Lubuntu over ubuntu and keep all data [closed]](https://askubuntu.com/questions/780521/installing-lubuntu-over-ubuntu-and-keep-all-data)  
* [Lubuntu](https://lubuntu.net/)  
* [Completely Remove LXDE/Lubuntu Desktop Environment](https://askubuntu.com/questions/86602/completely-remove-lxde-lubuntu-desktop-environment)  
* [RealVNC](https://www.realvnc.com/en/)  
* [How to install Lubuntu Desktop Environment and ONLY the desktop environment?](https://askubuntu.com/questions/243318/how-to-install-lubuntu-desktop-environment-and-only-thedesktop-environment)  