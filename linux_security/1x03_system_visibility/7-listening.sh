#!/bin/bash
ss -lnt4H | awk 'NR>1 {print $4}' | awk -F: '{print $NF}' | sort -n
