#!/bin/bash
ps -eo pid,state | awk -F' ' '{if ($2 == "Z") print $1}'
