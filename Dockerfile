ARG alpine_ver=3.20
FROM alpine:${alpine_ver}
WORKDIR /app
COPY . .
CMD [ "ls", "-la" ]