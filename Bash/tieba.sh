#!/bin/bash
# Tieba.sh: Library for loading Tieba things.

LIBDIR="$PWD"
alias include='source'

include $LIBDIR/urlencode.sh 

curl_poster(){
  curl -X POST -e "http://tieba.baidu.com/index.html"\
  -H "Connection:
Accept: \"application/x-ms-application, image/jpeg, application/xaml+xml, image/gif, image/pjpeg, application/x-ms-xbap, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*\"
Accept-Language: \"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0\"
Cookie: $_cookie
Cache-Control: \"no-cache\"
Content-Length: $_length" $*
}

login(){
  sendData="username=$(urlencode $username)


