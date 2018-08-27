#
# Hack chat server Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM alpine:latest

MAINTAINER jerryxu < jxhx@protonmail.com >

# Update & install packages
RUN apk --no-cache add ca-certificates git nodejs npm make

# install hackchat server
RUN git clone https://github.com/hack-chat/main.git hack.chat && \
cd hack.chat && \
npm install && \
#npm install http-server && \
ln -s /tmp /.pm2 
ADD config.json /hack.chat/

# install hackchat client
RUN cd /hack.chat/client && \
npm install

ADD client.js /hack.chat/client/

EXPOSE 6060
EXPOSE 3000

USER v2ray
ENV USER=v2ray

CMD cd /hack.chat && npm start
