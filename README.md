## Convert coins

Convert coin to other coin or money, based on [coingecko](https://api.coingecko.com/api) api.

You need to have:
 
- curl
- bc
- jq
- awk
- bash 


### USAGE:

```sh
./coin_converter.sh -f bitcoin -t eur -a 10
  -f, --from     coin name 
  -t, --to       money code (3 letters)
  -a, --amount   Amount to convert to"
```

<u>Exemple:</u>

```sh
└─▪ ./coin_converter.sh -f monero -t eur -a 1 
1 monero --> 57.31 eur
```

##### List all coins that you can convert from:

```sh
curl -s -X GET "https://api.coingecko.com/api/v3/coins/list" -H  "accept: application/json" | \
jq | grep "\"id\":" | cut -d " " -f6
```

##### You can convert to:

```
btc","eth","ltc","bch","bnb","eos","xrp","xlm","usd","aed","ars","aud","bdt",
"bhd","bmd","brl","cad","chf","clp","cny","czk","dkk","eur","gbp","hkd","huf",
"idr","ils","inr","jpy","krw","kwd","lkr","mmk","mxn","myr","nok","nzd","php",
"pkr","pln","rub","sar","sek","sgd","thb","try","twd","uah","vef","vnd","zar",
"xdr","xag","xau"
```

##### Docker

Build the container with:

```sh
docker build -t coin_converter .
```

Then, run as:

```sh
docker run coin_converter -f tezos -t eur -a 10
```
