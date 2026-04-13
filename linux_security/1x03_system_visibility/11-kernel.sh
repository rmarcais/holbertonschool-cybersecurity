#!/bin/bash
grep -q $1 /var/log/kern.log /var/log/messages
