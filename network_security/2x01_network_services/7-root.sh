#!/bin/bash
dig $1 +trace | grep -E "Received.+root-servers" | awk '{print $6}' | awk -F'#' '{print $1}'
