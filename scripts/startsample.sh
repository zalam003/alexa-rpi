#!/bin/bash


cd $HOME/alexa-rpi/sdk-build
PA_ALSA_PLUGHW=1 ./SampleApp/src/SampleApp ./Integration/AlexaClientSDKConfig.json ../third-party/alexa-rpi/models
