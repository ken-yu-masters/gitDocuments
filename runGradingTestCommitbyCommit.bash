#!/bin/bash
preCommitId=8f98086dbbb355c60d1f5e3a6f0bbee1a804cc8e

#Attribute codes:
#00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
#Text color codes:
#30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
#Background color codes:
#40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
textStyle_none=00
textStyle_bold=01
textStyle_underscore=04
textStyle_blink=05
textStyle_reverse=07
textStyle_concealed=08

TextColor_black=30
TextColor_red=31
TextColor_green=32
TextColor_yellow=33
TextColor_blue=34
TextColor_magenta=35
TextColor_cyan=36
TextColor_white=37
Y%
TextBackgroundColor_black=40
TextBackgroundColor_red=41
TextBackgroundColor_green=42
TextBackgroundColor_yellow=43
TextBackgroundColor_blue=44
TextBackgroundColor_magenta=45
TextBackgroundColor_cyan=46
TextBackgroundColor_white=47

endColor='\e[0m'


currentPath=`pwd`
currentDate=`date +"%Y_%m_%d_%H_%M_%S"`
cd /S/
allCommits=`git log --oneline --pretty=format:"%h"  ${preCommitId}...HEAD`
count=0
for co in $allCommits ; do
	echo -e "******************** \e[${textStyle_reverse};${TextColor_red}m ${count} \e[${TextColor_green}m checkout \e[${TextColor_yellow}m ${co} ${endColor} ********************"
	cd /S/
	git checkout $co
	echo -e "******************** \e[${TextColor_green}m compile \e[${TextColor_yellow}m ${co} ${endColor} ********************"
	devenv "/S/Vision/Source/Vision/Vision.sln" //build Release_Developer
	echo -e "******************** \e[${TextColor_green}m clean test cases ${endColor} ********************"
	cd /U/
	git reset --hard
	cd /U/Vision/TestFiles/GradingTests/
	
	outputfileName="${currentPath}/${currentDate}/${count}.${co}.txt"
	echo -e "******************** \e[${TextColor_green}m test \e[${TextColor_yellow}m ${co} \e[${TextColor_green}m > $outputfileName ${endColor} ********************"
	"Y:\Release_Developer\GradingTestRunner.exe" "Y:\Release_Developer\Vision.exe" "background" >  ${outputfileName}
	count=$((count+1))
done
