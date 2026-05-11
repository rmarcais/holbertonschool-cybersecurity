#!/bin/bash
traceroute $1 | tail -n +2 | wc -l
