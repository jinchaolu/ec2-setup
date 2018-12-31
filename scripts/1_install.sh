#!/bin/bash

# JL: Updates the list of available packages and their versions, but it does
#     not install or upgrade any packages.
sudo apt-get update
# JL: Actually installs newer versions of the packages you have. After updating
#     the lists, the package manager knows about available updates for the
#     software you have installed. This is why you first want to update.
#
#     -y, --yes, --assume-yes
#         Automatic yes to prompts. Assume "yes" as answer to all prompts and
#         run non-interactively. If an undesirable situation, such as
#         changing a held package or removing an essential package, occurs
#         then apt-get will abort.
sudo apt-get upgrade -y

# Install Lubuntu
# JL: Skip any interactive post-install configuration steps
#     Setting the DEBIAN_FRONTEND variable to noninteractive and using -y flag.
export DEBIAN_FRONTEND=noninteractive
# JL: Install Lubuntu desktop environment
sudo apt-get install -y lubuntu-desktop

# xterm is needed for xinit
# JL: Install xterm
sudo apt-get install -y xterm

# Install VirtualGL
# JL: Download VirtualGL package
# JL: wget stands for "web get". It is a command-line utility which downloads
#     files over a network.
#     ‘-O file’
#     ‘--output-document=file’
#         The documents will not be written to the appropriate files, but all 
#         will be concatenated together and written to file. If ‘-’ is used 
#         as file, documents will be printed to standard output, disabling 
#         link conversion. (Use ‘./-’ to print to a file literally named ‘-’.)
# JL: && 
#         means concatenate two commands together
#         Ex. "Command 1" && "Command 2"
#     \
#         Break down one line command to multiple lines without interpreted
#         A backslash escapes the next character from being interpreted by 
#         the shell. If the next character is a newline, then the newline 
#         will not be interpreted as the end of the command by the shell. It 
#         effectively allows the a command to span multiple lines.
wget https://sourceforge.net/projects/virtualgl/files/2.5.2/virtualgl_2.5.2_amd64.deb/download -O virtualgl_2.5.2_amd64.deb && \
# JL: Install VirtualGL package
# JL: dpkg is a package manager for Debian-based systems. It can install, 
#     remove, and build packages, but unlike other package management 
#     systems, it cannot automatically download and install packages or their #     dependencies.
#       -i, --install package-file...
#              Install the package. If --recursive or -R option is specified,
#              package-file must refer to a directory instead.
#
#              Installation consists of the following steps:
#
#              1. Extract the control files of the new package.
#
#              2. If another version of the same package was installed before
#              the new installation, execute prerm script of the old package.
#
#              3. Run preinst script, if provided by the package.
#
#              4. Unpack the new files, and at the same time back up the old
#              files, so that if something goes wrong, they can be restored.
#
#              5. If another version of the same package was installed before
#              the new installation, execute the postrm script of the old
#              package. Note that this script is executed after the preinst
#              script of the new package, because new files are written at
#              the same time old files are removed.
#
#              6. Configure the package. See --configure for detailed
#              information about how this is done.
sudo dpkg -i virtualgl*.deb && \
# JL: Remove downloaded VirtualGL package
# JL: rm - remove files or directories
rm virtualgl*.deb

# Install TurboVNC
# JL: Download TurboVNC package
wget https://sourceforge.net/projects/turbovnc/files/2.1.1/turbovnc_2.1.1_amd64.deb/download -O turbovnc_2.1.1_amd64.deb && \
# JL: Install TurboVNC package
sudo dpkg -i turbovnc*.deb && \
# JL: Remove downloaded TurboVNC package
rm turbovnc*.deb

# Install noVNC
# JL: Clone noVNC github repository
sudo git clone https://github.com/novnc/noVNC /opt/noVNC && \
# JL: Clone noVNC Websockify github repository
sudo git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify

# Configure VirtualGL
# JL: Stop light display manager
#     LightDM is a cross-desktop display manager.
sudo /etc/init.d/lightdm stop
# JL: Configure server for use with VirtualGL
#     VirtualGL is an open source package which gives any Unix or Linux 
#     remote display software the ability to run OpenGL applications with 
#     full 3D hardware acceleration.
#     "Flags (for unattended mode):"
#        "-config     Configure server for use with VirtualGL"
#        "-unconfig   Unconfigure server for use with VirtualGL"
#        "-s          Restrict 3D X server access to vglusers group [default]"
#        "+s          Open 3D X server access to all users of this machine"
#        "-f          Restrict framebuffer device access to vglusers group [default]"
#        "+f          Open framebuffer device access to all users of this machine"
#        "-t          Disable XTEST extension [default]"
#        "+t          Enable XTEST extension"
sudo /opt/VirtualGL/bin/vglserver_config -config +s +f -t
#sudo /etc/init.d/lightdm start

# Instead of exit - we'll update kernel and headers to prepare for Nvidia drivers install.
# JL: Install the gcc package and kernel sources in the Debian/Ubuntu Linux 
#     distribution
#     You can easily install the Linux kernel headers for currently running 
#     kernel version using the following commands at shell prompt. Header 
#     files and scripts for building modules for Linux kernel are included in 
#     linux-header-YOUR-Kernel-Version package. Open a terminal and type the 
#     command as root user to install linux-headers* package for your running 
#     kernel.
sudo apt-get install -y gcc linux-headers-$(uname -r)
# JL: Install the newest version of linux-aws package
sudo apt-get upgrade -y linux-aws

# Cleanup
# JL: Clears out the local repository of retrieved package files.
sudo apt-get clean && \
# JL: autoremove is used to remove packages that were automatically installed 
#     to satisfy dependencies for other packages and are now no longer needed.
sudo apt-get autoremove && \
# JL: Remove the cache contents in /var/lib/apt/lists after refreshing the 
#     package lists
#     When you run sudo apt-get update (or use the Refresh button in a 
#     package manager), a list of packages will get downloaded from the 
#     Ubuntu servers. These files are then stored in /var/lib/apt/lists/.
sudo rm -r /var/lib/apt/lists/*

# Add aliases
# JL: Define aliases
#     Aliases in Unix and Linux operating systems are cool. They let you 
#     define your own commands, or command shortcuts, so you can customize 
#     the command line, and make it work the way you want it to work.
#     cp -i	   prompt before overwrite (overrides a previous -n option)
#     mv -i	   prompt before overwrite
#     rm -i    Prompt before every removal.
echo "alias cp=\"cp -i\"" >> ~/.bash_aliases
echo "alias mv=\"mv -i\"" >> ~/.bash_aliases
echo "alias rm=\"rm -i\"" >> ~/.bash_aliases

echo ""
echo "******************************************************************"
echo "*                                                                *"
echo "* Rebooting for changes to take effect!                          *"
echo "*                                                                *"
echo "******************************************************************"
echo ""
# JL: This will perform a graceful shutdown and restart of the machine. This 
#     is what happens when you click restart from your menu.
sudo reboot
