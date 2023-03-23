FROM node:11 as builder

RUN apt-get install -y  git python make openssl tar gcc

ADD yapi.tgz /home/
RUN mkdir /api && mv /home/yapi-1.9.1 /api/vendors
RUN cd /api/vendors && \
    npm install --production --registry https://registry.npm.taobao.org

FROM node:11

MAINTAINER frd
ENV TZ="Asia/Shanghai" HOME="/"
WORKDIR ${HOME}

COPY --from=builder /api/vendors /api/vendors
COPY config.json /api/
EXPOSE 3001

COPY docker-entrypoint.sh /api/
RUN chmod 755 /api/docker-entrypoint.sh

CMD ["--initdb"]

ENTRYPOINT ["/api/docker-entrypoint.sh"]
