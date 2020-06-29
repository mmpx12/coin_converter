FROM  alpine:latest
COPY coin_converter.sh /usr/local/bin/.
RUN apk add bash curl jq bc
ENTRYPOINT ["/bin/bash", "/usr/local/bin/coin_converter.sh"]
