#!/bin/bash
# kernel version
KERN="${KERN:-$(uname -r)}"
KERN="${KERN/-*/}"
echo $KERN