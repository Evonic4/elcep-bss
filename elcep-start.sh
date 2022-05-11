#!/bin/bash

fhome=/usr/share/elcepbss/
sec4=$(sed -n "4p" $fhome"settings.conf" | tr -d '\r')



while true
do
sleep $sec4
/usr/share/elcepbss/elcep-bss.sh
done

