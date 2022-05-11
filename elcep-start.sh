#!/bin/bash

fhome=/usr/share/elcep-bss/
sec4=$(sed -n "4p" $fhome"settings.conf" | tr -d '\r')



while true
do
sleep $sec4
/usr/share/elcepbss/elcep-bss.sh
done

