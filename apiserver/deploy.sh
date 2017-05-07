# on development machine
docker build -t leontaolong/info344apiserver .
docker push leontaolong/info344apiserver

# on deployment server
docker pull leontaolong/info344apiserver
# docker stop and rm current running container
export TLSCERT=/etc/letsencrypt/live/api.leontaolong.me/fullchain.pem
export TLSKEY=/etc/letsencrypt/live/api.leontaolong.me/privkey.pem

docker run -d --name 344api -p 443:443\ 
-v /etc/letsencrypt:/etc/letsencrypt:ro \
-e TLSCERT=$TLSCERT -e TLSKEY=$TLSKEY \
-e REDISADDR=session-store:6379 -e DBADDR=user-store:27017 \
--network api-server-net \
leontaolong/info344apiserver