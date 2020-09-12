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

2. Make the installers executable using:
```
chmod 755 $HOME/alexa-rpi/scripts/*.sh
```

3. Setup & Test AVS
```
$HOME/alexa-rpi/scripts/build-avs.sh
```

4. Setup and Test Alexa Screen
```
$HOME/alexa-rpi/scripts/build-screen.sh
```

5. Start Alexa Screen
```
To be added
```
