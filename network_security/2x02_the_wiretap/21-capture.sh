#!/bin/bash
sudo tcpdump -ni tun0 -c 50 -w first_capture.pcap
