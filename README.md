# Certd

```
docker_image=certd:v1.0.0
docker_name=certd
docker_mnt=/data1/certd

if [ ! -d ${docker_mnt} ]
then
    mkdir -p ${docker_mnt}
fi

docker run -d -p 8081:80 --name ${docker_name} ${docker_image}
docker cp ${docker_name}:/etc/nginx/nginx.conf ${docker_mnt}/nginx.conf
docker cp ${docker_name}:/etc/nginx/http.d ${docker_mnt}/conf.d
docker cp ${docker_name}:/app/packages/ui/certd-server/public ${docker_mnt}/html
docker stop ${docker_name}
docker rm ${docker_name}

docker run -itd \
    -p 4431:443 \
    -p 7001:7001 \
    -v ${docker_mnt}/nginx.conf:/etc/nginx/nginx.conf \
    -v ${docker_mnt}/conf.d:/etc/nginx/http.d \
    -v ${docker_mnt}/html:/app/packages/ui/certd-server/public \
    -v ${docker_mnt}/cert:/data/cert \
    --name ${docker_name} \
    ${docker_image}

echo '
server {
    listen 443 ssl;
    server_name localhost;

    ssl_certificate /data/cert/certificate.crt;
    ssl_certificate_key /data/cert/private.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers HIGH:!aNULL:!MD5;

    location / {
        root   /app/packages/ui/certd-server/public;
        index  index.html index.htm;
    }

    location /api/ {
        proxy_pass http://localhost:7001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

}
' >> ${docker_mnt}/conf.d/default.conf

docker exec ${docker_name} sh -c "nginx -s reload"
```

