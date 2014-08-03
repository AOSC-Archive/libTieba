#!/bin/bash
alias include='source'

_tbcurl(){
  curl -b .tieba_cookie -c .tieba_cookie -H "Accept-Language: \"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3\"
Accept: \"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\"" $*
}
_tieba_curl(){ _tbcurl $*; }
_tieba_curl_POST(){
  _tbcurl -X POST -e "http://tieba.baidu.com/index.html" -b .tieba_cookie -c .tieba-cookie\
  -H "Connection:
Cache-Control: \"no-cache\"" $*
}
