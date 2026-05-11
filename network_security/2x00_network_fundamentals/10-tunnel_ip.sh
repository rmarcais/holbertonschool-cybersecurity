#!/bin/bash
ip -4 addr show tun0 | grep inet | awk -F' ' '{ printf $2 }'
