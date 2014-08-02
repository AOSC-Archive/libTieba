#!/bin/bash
# Tieba.sh: Library for loading Tieba things.
# -*- vim:fenc=utf-8:shiftwidth=2:softtabstop=2

LIBDIR="$PWD"
alias include='source'

include $LIBDIR/urlencode.sh 

curl_poster(){
  curl -X POST -e "http://tieba.baidu.com/index.html"\
  -H "Connection:
Accept: \"application/x-ms-application, image/jpeg, application/xaml+xml, image/gif, image/pjpeg, application/x-ms-xbap, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*\"
Accept-Language: \"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0\"
Cookie: $_tieba_cookie
Cache-Control: \"no-cache\"
Content-Length: $_post_length" $*
}

# Gets the token.
gettoken(){
  local _token_tbtmp=$(curl -X GET -H "Accept:\"application/x-ms-application, image/jpeg, application/xaml+xml, image/gif, image/pjpeg, application/x-ms-xbap, application/vnd.ms-excel, app    lication/vnd.ms-powerpoint, application/msword, */*\"
Cookie:$_tieba_cookie" -c .tieba_cookie "https://passport.baidu.com/v2/api/?loginliteinfo&tpl=tb")
  # Regex match, rewrite this..
  # Example: bdPass.api.loginLite._getInfo({ token:'[SOME 128-bit HEX]' ,codestring:'' ,immediatelySubmit:false ,index:'0' })
  [[ "$_token_temp" =~ (?<=token:.).{32} ]] && _tieba_token="$BASH_REMATCH"
  # Remember to set cookie.
  _tieba_cookie=$(cat .tieba_cookie)
}

# login UserName Password Captcha
login(){
  local sendData="username=$(urlencode $1)&password=${2}"
  sendData+="&callback=parent.bdPass.api.login._postCallback&charset=gb2312"
  sendData+="&codestring=${3}&index=0&isPhone=false&loginType=1&mem_pass=on"
  sendData+="&ppui_logintime=$RANDOM&staticpage=https%3A%2F%2Fpassport.baidu.com%2Fv2Jump.html"
  sendData+="&token=$token&tpl=tb&verifycode=${3}&mem_pass=on"
  curl_poster -d "$sendData" https://passport.baidu.com/v2/api/?login
}

