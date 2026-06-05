#!/bin/bash
tshark -r "$1" -q --export-objects http,./extracted/ && md5sum ./extracted/* | awk '{ print $1 }'
