#!/bin/bash

Name="kibana4"
Platform="linux-x64"
Package="${Name}-${Platform}.tar.gz"
Dir=`dirname $0`
cd $Dir/..
BaseDirName=`basename $PWD`
cd ..


tar --transform "s/^$BaseDirName/$Name/" -zcvf /tmp/$Package $BaseDirName/*

date "+%Y-%m-%d %H:%M:%S" > /tmp/${Package}.checksum
md5sum /tmp/$Package >> /tmp/${Package}.checksum
sha256sum /tmp/$Package >> /tmp/${Package}.checksum

ls -l /tmp/${Package}*
