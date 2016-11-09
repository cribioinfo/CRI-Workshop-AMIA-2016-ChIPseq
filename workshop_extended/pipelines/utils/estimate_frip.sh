#!/bin/bash
# Kyle Hernandez
# Center for Research Informatics
# University of Chicago
# License LGPLv3

inBamBed=$1
inIntersectBed=$2

treads=`wc -l $inBamBed | awk '{print $1}'`
fripEst=`cat $inIntersectBed | awk -v tot=$treads 'BEGIN{cnt=0}{cnt+=$NF}END{print cnt/tot}'`
echo $fripEst
