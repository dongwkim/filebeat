#!/bin/bash

fetch(){
echo "---------------------------------------------------"
echo "Decompress "$1
bunzip2 $1
echo "Fetched " $2
dir=${2}*.dat
cat $dir >> /es/archive/${3}.log
echo "Compress "${2}
bzip2 $dir
}
#for i in `ls /es/archive/2016_12_27_08_*_IostatExaWatcher_ees15fdcel1.samsung.com.dat.bz2`
#krx5bcl01.kr.oracle.com
for i in `ls /es/archive/2016_12_27*Mpstat*ees15fd2*.bz2`
do
filename=`echo $i |cut -d'.' -f1`
file=`echo $filename | cut -d'_' -f7`
hostname=`echo $i |cut -d'_' -f8 | cut -d'.' -f1,2,3`

  if [ "$file" = "VmstatExaWatcher" ]; then
    echo "My Hostname is "$hostname >> /es/archive/vmstat.log
    fetch $i $filename vmstat
  elif [ "$file" = "CellSrvStatExaWatcher" ]; then
    echo "My Hostname is "$hostname >> /es/archive/cellstat.log
    fetch $i $filename cellstat
  elif [ "$file" = "IostatExaWatcher" ]; then
    echo "My Hostname is "$hostname >> /es/archive/iostat.log
    fetch $i $filename iostat
  elif [ "$file" = "MpstatExaWatcher" ]; then
    echo "My Hostname is "$hostname >> /es/archive/mpstat.log
    fetch $i $filename mpstat
  else
    echo "Not Defined"
  fi
done
