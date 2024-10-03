#!/bin/bash

# /etc/hylafax 디렉터리 안에 파일이 있는지 확인
if [ -z "$(ls -A /etc/hylafax)" ]; then
    sleep 10
else
    sleep 10
    /etc/init.d/hylafax start
fi
