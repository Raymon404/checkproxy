#!/bin/bash
# -(c) zsecc0de-crew.id ~ widhisec
# https://github.com/widhisec
clear;
LIMITATOR=20
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2)
if [[ -z $(command -v curl) ]]; then
	printf "not installed curl \n"
#
elif [[ -z $(command -v grep) ]]; then
	printf "not installed grep"
fi
function Get_R(){
              scann="curl -s https://check.dichvusocks.us/func.php?socks=$x&checkpp=&proxystop=no"
              greb=$($scann | grep -oP '>(.*?)<' | tr -d "<>")
              if [[ "${greb}" =~ "LIVE" ]]; then
              	 printf "[LIVE] -> $x \n" >> live.txt
              	 printf "[${GREEN}LIVE${NORMAL}] -> ${NORMAL}$x \n"
              else
              	 printf "[DIEE] -> $x \n" >> die.txt
              	 printf "[${RED}DIEE${NORMAL}] -> ${NORMAL}$x \n"
              	 exit 1
              fi
}
function get(){
echo -e "
     ${CYAN} _
  ___| |__  _ __  _ __ _____  ___   _
 / __| '_ \| '_ \| '__/ _ \ \/ / | | |
| (__| | | | |_) | | | (_) >  <| |_| |
 \___|_| |_| .__/|_|  \___/_/\_\\__,  |
           |_|                  |___/
${GREEN}-------------------------------------- 
"
echo -en "${NORMAL}[?]list here :"; read lis
#echo -n "PROXY :"; read pro
#Get_R $pro
if [[ ! -f $lis ]]; then
	printf "[!]list not found \n"
	exit
fi
(
for x in $(cat $lis); do
	((thread=thread%LIMITATOR)); ((thread++==0)) && wait
	Get_R "$x" &
done
wait
)
}
get