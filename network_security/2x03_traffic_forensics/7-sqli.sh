#!/bin/bash
tshark -r "$1" -Y "http.request.uri contains UNION || http.request.uri contains SELECT" -T fields -e http.request.uri
