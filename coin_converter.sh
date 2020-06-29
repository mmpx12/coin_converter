#!/usr/bin/bash

banner(){
  echo """./converter -f monero -t usd -m 10
          -f, --from     coin name 
          -t, --to       money or coin code (3 letters)
          -a, --amount   Amount to convert to

You can convert from any coin but only to:

$convert_to"""
  exit 1
}

check_to(){
 if [[ ${convert_to[*]} =~ "$1," ]] ; then
   :;
 else
   echo -e "convert must be in :\n$convert_to"
   exit 1
  fi
} 

check_from(){
  coin=[$(curl -s -X GET "https://api.coingecko.com/api/v3/coins/list" -H  "accept: application/json" | jq | grep "\"id\":" | cut -d " " -f6)]
  if [[ ${coin[*]} =~ "\"$1\"," ]] ; then
    :;
  else
    echo "Coin name must be full (ex: bitcoin unstead btc)"
    exit 1
  fi
}

convert_to=["btc","eth","ltc","bch","bnb","eos","xrp","xlm","usd","aed","ars","aud","bdt","bhd","bmd","brl","cad","chf","clp","cny","czk","dkk","eur","gbp","hkd","huf","idr","ils","inr","jpy","krw","kwd","lkr","mmk","mxn","myr","nok","nzd","php","pkr","pln","rub","sar","sek","sgd","thb","try","twd","uah","vef","vnd","zar","xdr","xag","xau"]

which jq bc curl awk >/dev/null 2>&1
[[ $? == 0 ]] || echo "You need curl, awk, jq, bc for run this script"

args=$(echo "$@" | awk '{print NF}')
[[ $args -eq 0 || $args -ne 6 ]] && banner

while [ "$1" != "" ]; do
  case $1 in
    -f | --from )
      shift
      from=$1
      check_from "$from"
      ;;
    -t | --to )
      shift
      to=$1
      check_to "$to"
      ;;
    -a | --amount )
      shift
      montant=$1
      ;;
    * )
      banner
      ;;
    esac
    shift
done

price_one=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=$from&vs_currencies=$to" | jq .[].$to)
[[ ${price_one:0:1} == "." ]] && price_one="0$price_one"
echo "$montant $from -->" $(bc <<< $price_one*$montant) "$to"

