#!/bin/bash
sudo tcpdump -i tun0 -c 50 -w first_capture.pcap "icmp or tcp port 80"
