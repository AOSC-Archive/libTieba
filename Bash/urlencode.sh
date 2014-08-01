#!/bin/bash
## borrowed from http://blog.famzah.net/2011/08/25/url-escape-in-bash/
## Original file http://www.famzah.net/download/bash_urlencode/escape.sh.txt
## https://gist.github.com/duksis/3891185

# set -u

declare -A ord_hash # associative hash; requires Bash version 4

_init_urlencode() {
  # this is the whole ASCII set, without the chr(0) and chr(255) characters
  ASCII='  

 !"#$%&'\''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþ'

  # chr(0) cannot be stored in a Bash variable

  local idx
  for idx in {0..253}; do # 0..253 = 254 elements = length($ASCII)
    local c="${ASCII:$idx:1}" # VERY SLOW
    local store_idx=$(($idx+1))
    ord_hash["$c"]="$store_idx"
    # chr(255) cannot be used as a key
  done
}

urlencode() {
  local inp="$1"
  local len="${#inp}"
  local n=0
  local val
  while [ "$n" -lt "$len" ]; do
    local c="${inp:$n:1}" # VERY SLOW
    if [ "$c" == "ÿ" ]; then # chr(255) cannot be used as a key
      val=255
    else
      val="${ord_hash[$c]}"
    fi
    printf '%%%02X' "$val"
    n=$((n+1))
  done
}

_init_urlencode # call only once

perl_urlencode() {
echo -n "$1" | perl -MURI::Escape -ne 'print uri_escape($_)'
}
