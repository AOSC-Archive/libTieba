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

# login UserName Password Captcha
login(){
  sendData="username=$(urlencode $1)&password=${2}"
  sendData+="&callback=parent.bdPass.api.login._postCallback&charset=gb2312"
  sendData+="&codestring=${3}&index=0&isPhone=false&loginType=1&mem_pass=on"
  sendData+="&ppui_logintime=$RANDOM&staticpage=https%3A%2F%2Fpassport.baidu.com%2Fv2Jump.html"
  sendData+="&token=$token&tpl=tb&verifycode=${3}&mem_pass=on"
  curl_poster -d "$sendData" https://passport.baidu.com/v2/api/?login
}

