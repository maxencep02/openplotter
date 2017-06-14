#!/bin/bash
cd ~/.config
echo
echo "UPDATING PACKAGE LISTS..."
echo
sudo apt-get -qq update
if [ $? -ne 0 ]; then
	echo
	read -p "#### ERROR. ABORTING, PRESS ENTER TO EXIT ####"
	exit 1
fi
echo
echo "UPDATING PACKAGES..."
echo
sudo apt-get -qq upgrade
if [ $? -ne 0 ]; then
	echo
	read -p "#### ERROR. ABORTING, PRESS ENTER TO EXIT ####"
	exit 1
fi
echo
echo "INSTALLING DEPENDENCIES..."
echo
sudo apt-get -qq install gettext gpsd python-w1thermsensor x11vnc xrdp python-wxgtk3.0 hostapd dnsmasq isc-dhcp-server network-manager network-manager-gnome mpg123 python-gammu gammu mosquitto libusb-1.0-0-dev libfftw3-dev qt5-qmake libasound2-dev libpulse-dev  autoconf automake liboctave-dev python-dev python-matplotlib bridge-utils crudini libqt5gui5 libqt5core5a libqt5network5 libqt5widgets5 libqt5svg5 libportaudio2 make gcc xsltproc curl git build-essential libtool libusb-1.0.0-dev librtlsdr-dev rtl-sdr i2c-tools cmake libqt4-dev libproj-dev libnova-dev
if [ $? -ne 0 ]; then
	echo
	read -p "#### ERROR. ABORTING, PRESS ENTER TO EXIT ####"
	exit 1
fi
echo
echo "INSTALLING PYTHON PACKAGES..."
echo
sudo easy_install pip
sudo pip install --upgrade --quiet paho-mqtt pyudev pyrtlsdr pynmea2 twython websocket-client spidev PyMata requests_oauthlib requests  
if [ $? -ne 0 ]; then
	echo
	read -p "#### ERROR. ABORTING, PRESS ENTER TO EXIT ####"
	exit 1
fi
echo
echo "UPDATING NODEJS AND NODE-RED..."
echo
update-nodejs-and-nodered
sudo rm -rf /usr/share/applications/Node-RED.desktop
echo
echo "UPDATING SIGNAL K..."
echo
cd ~/.config/signalk-server-node
git pull
npm update
npm install
echo
echo "COMPILING PACKAGES..."
echo
cd ~/.config
mkdir compiling
cd compiling

cd ~/.config/compiling
git clone https://github.com/sailoog/kalibrate-rtl.git
cd kalibrate-rtl
./bootstrap && CXXFLAGS='-W -Wall -O3'
./configure
make -s
sudo make -s install

cd ~/.config/compiling
git clone https://github.com/sailoog/rtl_433.git
cd rtl_433/
mkdir build
cd build
cmake ../
make -s
sudo make -s install

cd ~/.config/compiling
git clone https://github.com/sailoog/aisdecoder.git
cd aisdecoder
cmake -DCMAKE_BUILD_TYPE=release
make -s
sudo cp aisdecoder /usr/local/bin

cd ~/.config/compiling
git clone https://github.com/sailoog/kplex.git
cd kplex
make -s
sudo make -s install

cd ~/.config/compiling
git clone git://github.com/sailoog/canboat
cd canboat
make -s
sudo make -s install

cd ~/.config/compiling
git clone https://github.com/sailoog/geomag.git
cd geomag/geomag
python setup.py -q build
sudo python setup.py -q install


sudo rm /usr/lib/libRTIMULib.so
sudo rm /usr/lib/libRTIMULib.so.7
sudo rm /usr/lib/libRTIMULib.so.7.2.1
sudo rm /usr/lib/python3/dist-packages/RTIMU.cpython-34m-arm-linux-gnueabihf.so
sudo rm /usr/lib/python3/dist-packages/RTIMULib-7.2.1.egg-info
sudo rm /usr/lib/python2.7/dist-packages/RTIMU.arm-linux-gnueabihf.so
sudo rm /usr/lib/python2.7/dist-packages/RTIMULib-7.2.1.egg-info
sudo rm /usr/lib/libRTIMULib.so
sudo rm /usr/lib/libRTIMULib.so.7
sudo rm /usr/lib/libRTIMULib.so.7.2.1
sudo rm /usr/bin/RTIMULibCal
sudo rm /usr/bin/RTIMULibDrive11
sudo rm -r /usr/include/IMUDrivers
sudo rm /usr/include/RTFusion.h
sudo rm /usr/include/RTFusionKalman4.h
sudo rm /usr/include/RTFusionRTQF.h
sudo rm /usr/include/RTIMUAccelCal.h
sudo rm /usr/include/RTIMUCalDefs.h
sudo rm /usr/include/RTIMUHal.h
sudo rm /usr/include/RTIMULib.h
sudo rm /usr/include/RTIMULibDefs.h
sudo rm /usr/include/RTIMUMagCal.h
sudo rm /usr/include/RTIMUSettings.h
sudo rm /usr/include/RTMath.h

cd ~/.config
mkdir compiling
cd compiling

cd ~/.config/compiling
git clone https://github.com/Nick-Currawong/RTIMULib2.git
cd RTIMULib2/Linux
mkdir build
cd build
cmake ..
make -j4 -s
sudo make -s install
sudo ldconfig
cd ..
cd RTIMULibCal
make -j4 -s
sudo make -s install
cd ..
cd RTIMULibDrive
make -j4 -s
sudo make -s install
cd ..
cd RTIMULibDrive10
make -j4 -s
sudo make -s install
cd ..
cd RTIMULibDemo
qmake
make -j4 -s
sudo make -s install
cd ..
cd RTIMULibDemoGL
qmake
make -j4 -s
sudo make -s install
cd ..
cd python
python setup.py -q build
sudo python setup.py -q install
python3 setup.py -q build
sudo python3 setup.py -q install

cd ~/.config
sudo rm -rf ~/.config/compiling/
echo
echo "INSTALLING/UPDATING GQRX..."
echo
wget https://github.com/csete/gqrx/releases/download/v2.6/gqrx-2.6-rpi3-3.tar.xz
tar xf gqrx-2.6-rpi3-3.tar.xz
rm gqrx-2.6-rpi3-3.tar.xz
rm -rf gqrx
mv gqrx-2.6-rpi3-3 gqrx
cd gqrx
./setup_gqrx.sh

cd ~/.config
