FROM debian
LABEL maintainer michel.promonet@free.fr

WORKDIR /v4l2rtspserver
COPY . /v4l2rtspserver

RUN apt-get update && apt-get install -y --no-install-recommends g++ autoconf automake libtool xz-utils cmake make liblog4cpp5-dev pkg-config git wget

RUN cmake . && make install && apt-get clean && rm -rf /var/lib/apt/lists/

FROM ubuntu:18.04

WORKDIR /usr/local/share/v4l2rtspserver
COPY --from=builder /usr/local/bin/ /usr/local/bin/

EXPOSE 8554

ENTRYPOINT [ "/usr/local/bin/v4l2rtspserver" ]
CMD [ "-S -P ${PORT}" ]
