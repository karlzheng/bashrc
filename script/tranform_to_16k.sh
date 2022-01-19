#!/bin/bash

IFS=$'\n'
mkdir -p wavefiles
#for file in *.wav
for file in *.mp3;do
	c=${file}
	echo $c
	#sox $c -r 16000 -c 1 -b 16 wavefiles/$c.wav
	sox $c -r 8000 -c 1 -b 16 wavefiles/$c.wav
done