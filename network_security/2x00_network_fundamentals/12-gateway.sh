#!/bin/bash
ip route show default | awk -F' ' '{ print $3 }'
