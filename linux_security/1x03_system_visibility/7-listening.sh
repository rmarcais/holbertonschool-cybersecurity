#!/bin/bash
ss -lnt4H | awk '{print $4}' | awk -F: '{print $NF}' | sort -n
