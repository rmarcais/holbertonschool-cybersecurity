#!/bin/bash
ps -eo pid,comm --sort=-pcpu --no-headers | head -1
