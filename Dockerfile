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
RUN git clone https://github.com/AndrewBelt/hack.chat.git && \
cd hack.chat && \
npm install
ADD config.json /hack.chat/

#install deps
RUN cd /hack.chat && \
npm install


# install hackchat client
RUN cd /hack.chat/client && \
npm install -g less jade http-server && \
make
ADD client.js /hack.chat/client/

EXPOSE 6060
CMD cd /hack.chat && npm start
