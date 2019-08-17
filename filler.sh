#!/bin/bash

nova list | awk -F "|" ' /ACTIVE/ { print $3 $7}' | awk '{print $1,$2}' | sed 's/curix-net=//g' | tr -d , > ip-list.txt
python filler.py
rm ip-list.txt
