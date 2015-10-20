#!/bin/bash
wget https://raw.github.com/arithx/shstack/master/base.sh
chmod +x base.sh
nohup ./base.sh 2>&1> base.log &
wait $!
