#!/bin/bash

set -e

/usr/sbin/sshd

if [ $# -eq 0 ]; then
    set -- bash
fi

exec gosu DUMMY_USERNAME "$@"
