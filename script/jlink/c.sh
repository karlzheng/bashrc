#!/bin/bash
JLinkScriptFile=$PWD/connect.script
#./JLinkExe -if SWD -device NRF51822_XXAA -speed 4000 -CommanderScript $JLinkScriptFile
./JLinkExe -if SWD -device NRF52832_XXAA -speed 4000 -CommanderScript $JLinkScriptFile
