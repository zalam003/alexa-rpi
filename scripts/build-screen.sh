#!/bin/bash

# Step 7: Download and build the APL Core Library
cd $HOME/sdk_folder
git clone --single-branch --branch v1.3.3 git://github.com/alexa/apl-core-library.git 

cd $HOME/sdk_folder/apl-core-library
mkdir build
cd build
cmake ..
make

# Step 8: Install Alexa Smart Screen SDK dependencies
cd $HOME/sdk_folder/third-party
wget https://github.com/zaphoyd/websocketpp/archive/0.8.1.tar.gz -O websocketpp-0.8.1.tar.gz
tar -xvzf websocketpp-0.8.1.tar.gz
rm websocketpp-0.8.1.tar.gz

cd $HOME/sdk_folder/third-party
sudo apt-get -y install libasio-dev --no-install-recommends 

cd $HOME/sdk_folder/third-party
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt-get install -y nodejs


# Step 9: Download and build the Alexa Smart Screen SDK
cd $HOME/sdk_folder
git clone git://github.com/alexa/alexa-smart-screen-sdk.git

cp $HOME/Downloads/package-lock.json $HOME/sdk_folder/alexa-smart-screen-sdk/modules/GUI/js/.

cd $HOME/sdk_folder
mkdir ss-build
cd ss-build

cmake -DCMAKE_PREFIX_PATH=$HOME/sdk_folder/sdk-install \
 -DSENSORY_KEY_WORD_DETECTOR=ON \
 -DSENSORY_KEY_WORD_DETECTOR_LIB_PATH=$HOME/sdk_folder/third-party/alexa-rpi/lib/libsnsr.a \
 -DSENSORY_KEY_WORD_DETECTOR_INCLUDE_DIR=$HOME/sdk_folder/third-party/alexa-rpi/include \
 -DWEBSOCKETPP_INCLUDE_DIR=$HOME/sdk_folder/third-party/websocketpp-0.8.1 \
 -DDISABLE_WEBSOCKET_SSL=ON \
 -DGSTREAMER_MEDIA_PLAYER=ON \
 -DCMAKE_BUILD_TYPE=DEBUG \
 -DPORTAUDIO=ON -DPORTAUDIO_LIB_PATH=$HOME/sdk_folder/third-party/portaudio/lib/.libs/libportaudio.a \
 -DPORTAUDIO_INCLUDE_DIR=$HOME/sdk_folder/third-party/portaudio/include/ \
 -DAPL_CORE=ON \
 -DAPLCORE_INCLUDE_DIR=$HOME/sdk_folder/apl-core-library/aplcore/include \
 -DAPLCORE_LIB_DIR=$HOME/sdk_folder/apl-core-library/build/aplcore \
 -DYOGA_INCLUDE_DIR=$HOME/sdk_folder/apl-core-library/build/yoga-prefix/src/yoga \
 -DYOGA_LIB_DIR=$HOME/sdk_folder/apl-core-library/build/lib \
  ../alexa-smart-screen-sdk
  
make

read -p "Test the Alexa Smart Screen SDK sample app [Y/n]: "

# Step 10: Test the Alexa Smart Screen SDK sample app
cd $HOME/sdk_folder/ss-build
PA_ALSA_PLUGHW=1 ./modules/Alexa/SampleApp/src/SampleApp -C \
$HOME/sdk_folder/sdk-build/Integration/AlexaClientSDKConfig.json -C \
$HOME/sdk_folder/alexa-smart-screen-sdk/modules/GUI/config/SmartScreenSDKConfig.json -L INFO