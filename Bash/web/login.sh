#!/bin/bash
# Login.sh: tieba login stuffs
_tiebafuncs+="gettoken captcha login"
# Gets the token.
tieba_gettoken(){
  local _token_tbtmp=$(_tbcurl -X GET "https://passport.baidu.com/v2/api/?loginliteinfo&tpl=tb")
  # Regex match
  # Example string: bdPass.api.loginLite._getInfo({ token:'[SOME 128-bit HEX]' ,codestring:'' ,immediatelySubmit:false ,index:'0' })
  [[ "$_token_temp" =~ [0-9a-f]{32} ]] && _tieba_token="$BASH_REMATCH"
}

tieba_captcha(){

}
# login UserName Password Captcha
tieba_login(){
  local sendData="username=$(urlencode $1)&password=${2}"
  sendData+="&callback=parent.bdPass.api.login._postCallback&charset=gb2312"
  sendData+="&codestring=${3}&index=0&isPhone=false&loginType=1&mem_pass=on"
  sendData+="&ppui_logintime=$RANDOM&staticpage=https%3A%2F%2Fpassport.baidu.com%2Fv2Jump.html"
  sendData+="&token=$_tieba_token&tpl=tb&verifycode=${3}&mem_pass=on"
  _tieba_curl_POST -d "$sendData" https://passport.baidu.com/v2/api/?login
}
