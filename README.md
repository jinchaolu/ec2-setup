# Configure_AWS_Instance_for_Udacity_Self_Driving_Car_Engineer_Nanodegree
Configure AWS instance for Udacity Self-Driving Car Engineer Nanodegree step by step.

## Overview
___
This repository is original from [ec2-setup](https://github.com/yrahal/ec2-setup).  

List of 4 scripts to prepare a stock Ubuntu AMI on AWS to act as a remote workstation, including 3D acceleration (when used with a GPU instance).  
The scripts (located under `scripts/`) take care of installing Lubuntu, TurboVNC, VirtualGL, Nvidia drivers, Docker and nvidia-docker plugin to expose the graphics hardware to Docker containers and enable the execution of 3D accelerated apps inside them.  
This tutorial is prepared for the final project in term 3 of Udacity Self-Driving Engineering Nanodegree. In this tutorial,
you will learn how to setup a AWS EC2 instance from existing AMI and install the Lubuntu desktop.(https://lubuntu.net/)  
Then you will use [TigerVNC](https://tigervnc.org/) viewer to connect to the Lubuntu desktop from Windows 7 or 10.  
## Tools
___
* [PuTTY](https://www.putty.org/)  
* [TigerVNC](https://tigervnc.org/)  
## Steps  
---  
### Installation  
Step1: Run the `1_install.sh` script.  
`$ source 1_install.sh`  
The machine will reboot at the end of the process. You'll have to wait a bit and then reconnect to it.  
Step2: Run the `2_install-nvidia-drivers-g2.sh` script.  
`$ source 2_install-nvidia-drivers-g2.sh`  
This script is written for a G2 instance.  
An interactive installer will run, during which you'll have to accept the license and ignore the warnings.  
The machine will again reboot at the end of the process.  
Step3: Run the `3_install-docker.sh` script.  
`$ source 3_install-docker.sh`  
This will install and configure Docker CE and the nvidia-docker plugin.  
Step4: Run the 4_startup.sh script.  
`$ source 4_startup.sh`  
This will ask you for password at the first time.  
Step5: Replace the `xstartup.turbovnc` file in `/home/ubuntu/.vnc/xstartup`  
This will launch the default ubuntu 16.04 desktio environment .  

### Test
To check that the hardware is correctly set up, run:  
`$ nvidia-smi`

To check that GPUs are correctly exposed to Docker containers (it should have the same output as the previous command), run:  
`$ nvidia-docker run --rm nvidia/cuda:8.0-devel nvidia-smi`  

Note: The `nvidia/cuda` image is relatively big, so you can either choose to remove it afterwards if you don't plan on using it, or to simply test with the Docker image you'll be using later.  

I've tested the scripts with a basic Ubuntu 16.04 image on a G2 instance.

### Usage

Now you can just run the `startup.sh` script to initiate the X server and launch VNC on `PORT 5901`
(the first time, it will ask you to create a password for the VNC server).

If you reboot your instance, or if you decide to save a snapshot of your instance and use it as an
image for future instances, then all you need is to run `startup.sh` once the instance is up.

When connecting, I prefer to only open `PORT 22` on the instance, and create an SSH tunnel for VNC
like so:

`$ ssh -i permission_file.pem -L 5901:localhost:5901 ubuntu@ip_address`

Then I can use a VNC client to connect to `localhost:5901`.

You can also open `PORT 5901` on your instance and directly connect to it, but the connection won't
be encrypted...

Make sure to use a VNC client that supports VirtualGL (TigerVNC, TurboVNC, ...). Once you're in, you'll
have a full Lubuntu desktop with hardware acceleration!

If you wish to view your desktop in the browser, you need to uncomment the final line in the `startup.sh`
script to run a noVNC server and then create an SSH tunnel for `PORT 6080`:

`$ ssh -i permission_file.pem -L 6080:localhost:6080 ubuntu@ip_address`

You can access your desktop in the browser at `localhost:6080/vnc.html`.

To take advantage of VirtualGL, launch your 3D applications prepended by `vglrun`. For example:

`$ vglrun firefox`

And visit http://webglreport.com/ to check that you're effectively using the Nvidia hardware :-)

## Conclusions  
---  
## Tips  
---  
You could save more money by using spot instance and attaching an external volume where you can save your work.
## References
---  
* [ec2-setup](https://github.com/yrahal/ec2-setup): Original repository.  
* [Remote server setup for VNC](https://github.com/UV-CDAT/uvcdat/wiki/Remote-server-setup-for-VNC): 
TurboVNC and VirtualGL installation.  
* [Linux Accelerated Computing Instances](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/accelerated-computing-instances.html#install-nvidia-driver): 
Nvidia drivers installation.  
* [Using Docker to Set Up a Deep Learning Environment on AWS](https://medium.com/towards-data-science/using-docker-to-set-up-a-deep-learning-environment-on-aws-6af37a78c551): 
Nvidia-docker installation.  
* [HW accelerated GUI apps on Docker](https://medium.com/@pigiuz/hw-accelerated-gui-apps-on-docker-7fd424fe813e): 
Using Docker and VirtualGL for 3D applications.  
* [noVNC GitHub page](https://github.com/novnc/noVNC): noVNC installation and usage.  
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
