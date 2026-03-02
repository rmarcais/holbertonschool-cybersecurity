#!/bin/bash
setfacl -d -m u:$2:$3 $1
