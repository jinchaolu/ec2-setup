#!/bin/bash

# For g2 instance:
# JL: Download nvidia linux x64 (AMD64/EM64T) display driver
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/367.106/NVIDIA-Linux-x86_64-367.106.run
# JL: Stop current X server session
sudo service lightdm stop
# JL: Install nvidia linux x64 (AMD64/EM64T) display driver
sudo /bin/bash NVIDIA-*.run --no-questions --run-nvidia-xconfig
# JL: Remove downloaded nvidia display driver
rm -f *.run

# Edit /etc/X11/xorg.conf - See https://stackoverflow.com/questions/34805794/virtualgl-and-turbovnc-extension-glx-missing-on-display-0-0
# sudo nano /etc/X11/xorg.conf
# And under the "Device" section:
# BusID          "0:3:0"
# So must add under the "Screen" section:
# Option         "UseDisplayDevice" "none"
# JL: Edit the xorg.conf for remote access
#     try
#		 ... | awk '$1 == "1" {print $2 ; l=NR+1 ; } NR == l { print $1 ;}'
#     where
#        $1 == "1" select line where first field is 1
#        {print $2 print it's value
#        l=NR+1 ; } remember next line
#        NR == l select second line
#        { print $1 ;} print first field
sudo awk '/VendorName     \"NVIDIA Corporation\"/{print;print "    BusID          \"0:3:0\"";next}1' /etc/X11/xorg.conf > tmp && \
sudo mv tmp /etc/X11/xorg.conf
sudo awk '/DefaultDepth    24/{print;print "    Option        \"UseDisplayDevice\" \"none\"";next}1' /etc/X11/xorg.conf > tmp && \
sudo mv tmp /etc/X11/xorg.conf

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
