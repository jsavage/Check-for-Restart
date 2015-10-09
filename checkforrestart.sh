#!/bin/bash
# This script checks a webhook called rebootserver and reboots the local server
# if the response returned is not as expected

OUT=$( curl -qSfsw '\n%{http_code}' https://accountname.hookify.me/rebootserver ) 2>/dev/null
#now get exit code
RET=$?
if [[ RET -ne 0 ]] ; then
    echo "Error $RET"
    echo  "HTTP Error: $(echo "$OUT" | tail -n1 )"
else
    echo "Success, HTTP Status is:"
    echo "$OUT" | tail -n1
    echo "Response is:"
    echo "$OUT" | head -n-1
    if [[ $OUT != *"QSL"* ]] ; then
        echo "Response was not QSL" # Someone wants the server to re-boot
        sudo reboot
    else
        echo "Response was QSL"
    fi
fi
