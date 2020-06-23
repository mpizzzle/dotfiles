#!/bin/sh

for FILE in $@;
do
  len=${#FILE}-4
  ffmpeg -i $FILE -vn ./${FILE:0:$len}.flac
done
