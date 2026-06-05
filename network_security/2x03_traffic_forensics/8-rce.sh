#!/bin/bash
tshark -r "$1" -Y "frame contains 2F:62:69:6E:2F:73:68" | wc -l
