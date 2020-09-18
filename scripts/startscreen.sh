#!/bin/bash

cd $HOME/alexa-rpi/ss-build
./StartSample.sh \
-C $HOME/alexa-rpi/sdk-build/Integration/AlexaClientSDKConfig.json \
-K ../third-party/alexa-rpi/models \
-L INFO \
-C $HOME/alexa-rpi/alexa-smart-screen-sdk/modules/GUI/config/SmartScreenSDKConfig.json
