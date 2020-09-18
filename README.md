# alexa-rpi
## Make your own Amazon Echo Screen

****************************************************************   
### A. Create Security Profile   
****************************************************************  

1. Create a security profile for alexa-avs-sample-app if you already don't have one.
```
https://github.com/alexa/avs-device-sdk/wiki/Create-Security-Profile  
```

2. Download the **"config.json"** file and place it in the **/home/pi/DIY-Echo-Show/Alexa** directory.  


****************************************************************   
### B. Download and Image
****************************************************************

1. Download the following Rasberry Pi Image:
```
https://downloads.raspberrypi.org/raspios_full_armhf/images/raspios_full_armhf-2020-08-24/2020-08-20-raspios-buster-armhf-full.zip
```

2. Image SD card and boot Rasberry Pi

***************************************************************
### C. Setup Alexa Screen
***************************************************************
1. Clone the git using:
```
git clone https://github.com/zalam003/alexa-rpi.git  
```

2. Build AVS
```
$HOME/alexa-rpi/scripts/build-avs.sh
```

3. Register and test AVS
```
$HOME/alexa-rpi/scripts/test-avs.sh
```

4. Build Alexa Screen
```
$HOME/alexa-rpi/scripts/build-screen.sh
```

5. Setup and Test Alexa Screen
```
$HOME/alexa-rpi/scripts/test-screen.sh
```

Open Chrome or Firefox browser and start Alexa Screen:
```
file:///home/pi/alexa-rpi/ss-build/modules/GUI/index.html
```

6. Setup Raspberry to auto start Alexa Screen
```
sudo cp $HOME/alexa-rpi/scripts/alexa.service /lib/systemd/system/.
sudo systemctl daemon-reload
sudo reboot
```
