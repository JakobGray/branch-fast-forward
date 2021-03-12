FROM alpine:latest

RUN apk --no-cache add bash git

ADD fastforward.sh /fastforward.sh

ENTRYPOINT ["/fastforward.sh"]