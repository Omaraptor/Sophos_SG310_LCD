#!/bin/bash

stty -F /dev/ttyS1 2400         #IR1602IB is setup to run at 2400bps
# stty -F /dev/ttyS1            #BREAKPOINT: Make sure the set baud is saved    
Whos= w -h -s |grep pts         #Who is logged to ssh server

Whois=${Whos:0:8}               #grab user name field
IP=${Whos:18:15}                #grab IP field


printf " %.0s" {1..80}  > /dev/ttyS1    #fill the LCD with spaces
echo 'fefd' | xxd -r -p > /dev/ttyS1    #hex values 'fefd' HOME the cursor on IR1602IB for Sophos SG310

printf "%s from" $Whois > /dev/ttyS1    #print login name on the LCD
printf " %.0s" {1..31}  > /dev/ttyS1    #Print 16 characters, then add 24 to get to the next line.
printf "%s" $IP         > /dev/ttyS1    #print IP address
printf " %.0s" {1..4}   > /dev/ttyS1    #move the cursor off the screen

# So this works.
# The LCD formatting is weird, because the LCD doesn't seem to conform to normal Hitachi commands.
