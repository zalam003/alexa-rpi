#!/bin/bash

echo "Register and Test the Alexa Smart Screen SDK.."

# Step 10: Test the Alexa Smart Screen SDK sample app
cd $HOME/alexa-rpi/ss-build
PA_ALSA_PLUGHW=1 ./modules/Alexa/SampleApp/src/SampleApp -C \
-C $HOME/alexa-rpi/sdk-build/Integration/AlexaClientSDKConfig.json \
-K ../third-party/alexa-rpi/models \
-L INFO \
-C $HOME/alexa-rpi/alexa-smart-screen-sdk/modules/GUI/config/SmartScreenSDKConfig.json
