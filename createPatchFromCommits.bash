#!/bin/bash
commits="d470695c4a7 f51f3ff9088 9757992351e fd5cd2c3e9f 17d2edbd0e5 6bc9ba8a96e 873fa9f32eb 9339362222f 7d7b6024805 c796ff6e823 8be836c4dea fe520940404"
outputDir='S:\patches'
count=0
for co in $commits ; do
	fileName=`git format-patch $co -1 -o $outputDir`
	newFileName=`echo $fileName | awk -F "-" '{for (i=2;i<NF;i++)printf "%s_", $i;printf "%s",$NF}'`
	newFileName="${outputDir}\\${count}-${co}-${newFileName}"
	echo "move from $fileName to $newFileName"
	mv $fileName $newFileName
	count=$((count+1))
done
