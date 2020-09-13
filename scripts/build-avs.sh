#!/bin/bash

sudo apt-get update

cd /home/pi
mkdir alexa-rpi
cd alexa-rpi
mkdir sdk-build sdk-source third-party sdk-install db

sudo apt-get -y install \
   git gcc cmake build-essential libsqlite3-dev libcurl4-openssl-dev libfaad-dev \
   libssl-dev libsoup2.4-dev libgcrypt20-dev libgstreamer-plugins-bad1.0-dev \
   gstreamer1.0-plugins-good libasound2-dev doxygen
   
cd $HOME/alexa-rpi/third-party

wget -c http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz
tar zxf pa_stable_v190600_20161030.tgz
rm pa_stable_v190600_20161030.tgz

cd portaudio
./configure --without-jack

cd $HOME/alexa-rpi/third-party/portaudio
make -j4

# Install package to parse json file
pip install commentjson

#
cd $HOME/alexa-rpi/sdk-source
git clone --single-branch --branch v1.20.0 git://github.com/alexa/avs-device-sdk.git

cd $HOME/alexa-rpi/third-party
git clone git://github.com/Sensory/alexa-rpi.git
cd $HOME/alexa-rpi/third-party/alexa-rpi/bin/
./license.sh

#
cd $HOME/alexa-rpi/sdk-build
cmake $HOME/alexa-rpi/sdk-source/avs-device-sdk \
 -DSENSORY_KEY_WORD_DETECTOR=ON \
 -DSENSORY_KEY_WORD_DETECTOR_LIB_PATH=$HOME/alexa-rpi/third-party/alexa-rpi/lib/libsnsr.a \
 -DSENSORY_KEY_WORD_DETECTOR_INCLUDE_DIR=$HOME/alexa-rpi/third-party/alexa-rpi/include \
 -DGSTREAMER_MEDIA_PLAYER=ON \
 -DPORTAUDIO=ON \
 -DPORTAUDIO_LIB_PATH=$HOME/alexa-rpi/third-party/portaudio/lib/.libs/libportaudio.a \
 -DPORTAUDIO_INCLUDE_DIR=$HOME/alexa-rpi/third-party/portaudio/include \
 -DCMAKE_BUILD_TYPE=DEBUG \
 -DCMAKE_INSTALL_PREFIX=$HOME/alexa-rpi/sdk-install \
 -DRAPIDJSON_MEM_OPTIMIZATION=OFF

#make SampleApp
make install

# Update AlexaClientSDKConfig.json
BUILD_PATH=$HOME/alexa-rpi/sdk-build
OUTPUT_CONFIG_FILE="$BUILD_PATH/Integration/AlexaClientSDKConfig.json"
TEMP_CONFIG_FILE="$BUILD_PATH/Integration/tmp_AlexaClientSDKConfig.json"

cp $HOME/Downloads/config.json $HOME/alexa-rpi/sdk-source/avs-device-sdk/tools/Install

cd $HOME/alexa-rpi/sdk-source/avs-device-sdk/tools/Install 
bash genConfig.sh config.json \
 123456 \
 $HOME/alexa-rpi/db \
 $HOME/alexa-rpi/sdk-source/avs-device-sdk \
 $TEMP_CONFIG_FILE \
 -DSDK_CONFIG_MANUFACTURER_NAME="raspberrypi" \
 -DSDK_CONFIG_DEVICE_DESCRIPTION="raspberrypi"
 
# Create configuration file with audioSink configuration at the beginning of the file
cat << EOF > "$OUTPUT_CONFIG_FILE"
 {
    "gstreamerMediaPlayer":{
        "audioSink":"alsasink"
    },
EOF

# Delete first line from temp file to remove opening bracket
sed -i -e "1d" $TEMP_CONFIG_FILE

# Append temp file to configuration file
cat $TEMP_CONFIG_FILE >> $OUTPUT_CONFIG_FILE

# Replace timezone
sed -i -e 's/Vancouver/New_York/g' "$OUTPUT_CONFIG_FILE"

# Delete temp file
rm $TEMP_CONFIG_FILE
 
cp $OUTPUT_CONFIG_FILE $HOME/alexa-rpi/BACKUP-AlexaClientSDKConfig.json

#####
# Configure the microphone and speaker
cat << EOF > ~/.asoundrc
pcm.!default {
   type asym
   playback.pcm {
     type plug
     slave.pcm "hw:0,0"
   }
   capture.pcm {
     type plug
      slave.pcm "hw:1,0"
   }
 }
EOF

read -p "Verify the AVS Device SDK build [Y/n]: "

# Step 6: Verify the AVS Device SDK build
cd $HOME/alexa-rpi/sdk-build
#PA_ALSA_PLUGHW=1 ./SampleApp/src/SampleApp ./Integration/AlexaClientSDKConfig.json INFO
PA_ALSA_PLUGHW=1 ./SampleApp/src/SampleApp ./Integration/AlexaClientSDKConfig.json ../third-party/alexa-rpi/models