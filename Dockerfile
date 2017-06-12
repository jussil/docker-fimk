FROM openjdk:8
MAINTAINER Jussi Lindfors
LABEL version="0.6.4"

ENV SERVER_ROOT=/server
ENV SERVER_BIN="${SERVER_ROOT}/run.sh"
ENV SERVER_VERSION="0.6.4"
ENV SERVER_VERSION_ZIP="fim-${SERVER_VERSION}"
ENV SERVER_PROPERTY_PREFIX="nxt__"
ENV SERVER_PROPERTY_FILE="nxt.properties"

RUN apt-get update \
  && apt-get install -yy curl screen \
  && rm -Rf /var/lib/apt/lists/* \
  && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
  && apt-get clean

RUN cd /tmp \
  && wget -q https://github.com/fimkrypto/fimk/releases/download/v${SERVER_VERSION}/${SERVER_VERSION_ZIP}.zip \
  && unzip ${SERVER_VERSION_ZIP}.zip -d ${SERVER_VERSION_ZIP} \
  && mv ${SERVER_VERSION_ZIP} ${SERVER_ROOT} \
  && rm -rf /tmp/*

ADD *.sh /
RUN chmod +x /*.sh ${SERVER_BIN} 

EXPOSE 7884 7885 7886

CMD ["/run.sh"]