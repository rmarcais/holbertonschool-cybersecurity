#!/bin/bash
dig $1 A +noall +answer | awk '{printf "%s", $5}'
