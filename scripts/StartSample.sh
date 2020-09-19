#!/usr/bin/env bash

#
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License.
# A copy of the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed
# on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
# express or implied. See the License for the specific language governing
# permissions and limitations under the License.
#

FILE_URL="file://$(pwd)//modules/GUI/index.html"
export PATH=/home/pi/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

((command -v google-chrome && google-chrome "$FILE_URL") || \
(command -v firefox && firefox "$FILE_URL") || \
(command -v chromium-browser && chromium-browser --kiosk "$FILE_URL" &) || \
(echo "Couldn't find a supported browser. Please install Chrome or Firefox" && exit 1)) &&  \
./modules/Alexa/SampleApp/src/SampleApp "$@"

