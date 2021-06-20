#Base Image
FROM ghcr.io/arghyac35/aria-telegram-mirror-bot:main

WORKDIR /bot/
RUN rm /bot/start.sh
COPY ./start.sh /bot/start.sh
RUN apk add nginx
RUN npm install http-server -g
CMD ["bash", "start.sh"]
