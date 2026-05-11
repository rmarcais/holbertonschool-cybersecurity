#!/bin/bash
ip addr show tun0 | grep 'inet ' | awk -F' ' '{ printf $2 }'
