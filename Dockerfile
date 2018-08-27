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
npm install
ADD config.json /hack.chat/

#RUN npm install ws@1.1.1

#install deps
RUN cd /hack.chat && \
npm install


# install hackchat client
RUN cd /hack.chat/client && \
npm install -g less jade http-server && \
make
ADD client.js /hack.chat/client/

EXPOSE 6060
EXPOSE 8080

USER v2ray
ENV USER=v2ray

CMD cd /hack.chat && npm start
