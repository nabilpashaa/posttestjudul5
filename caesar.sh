#!/bin/bash
# Script Caesar Cipher sederhana
# Pemakaian:
#   ./caesar.sh encode <input_file> <shift> > output.txt
#   ./caesar.sh decode <input_file> <shift> > output.txt
#

if [ $# -lt 3 ]; then
    echo "Usage: $0 {encode|decode} <input_file> <shift>"
    exit 1
fi

MODE=$1
INPUT=$2
SHIFT=$3

if [ ! -f "$INPUT" ]; then
    echo "Error: File '$INPUT' tidak ditemukan."
    exit 1
fi

# Jika decode, geser balik (26 - shift)
if [ "$MODE" = "decode" ]; then
    SHIFT=$((26 - SHIFT))
fi

# Lakukan Caesar Cipher menggunakan tr
cat "$INPUT" | tr 'A-Z' "$(echo {A..Z} | tr -d ' ' | awk -v s=$SHIFT '{print substr($0, s+1) substr($0, 1, s)}')" \
             | tr 'a-z' "$(echo {a..z} | tr -d ' ' | awk -v s=$SHIFT '{print substr($0, s+1) substr($0, 1, s)}')"
