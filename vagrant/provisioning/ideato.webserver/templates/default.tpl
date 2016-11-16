server {
    listen  80;

    client_max_body_size 20M;

    root {{ backend_application_root_dir }};
    index app.php index.html index.php;

    server_name {{ backend_server_name_virtual_host }};

    error_log /var/log/nginx/error-{{ backend_server_name_virtual_host }}.log;
    access_log /var/log/nginx/access-{{ backend_server_name_virtual_host }}.log;

    add_header 'Access-Control-Allow-Origin' '*';
    add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, PUT, DELETE';
    add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,X-Auth-Token,Authorization';
    add_header 'Access-Control-Allow-Credentials' 'true';

    location @rewriteapp {
        # riscrittura di tutto su app.php
        rewrite ^(.*)$ /app_dev.php/$1 last;
    }

    location / {
     try_files $uri @rewriteapp;

     if ($request_method = OPTIONS ) {
       return 204;
     }
    }

    error_page 404 /404.html;

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }

    location ~ ^/(app|app_dev|app_test)\.php(/|$) {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php-fpm/php-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;

        if ($request_method = OPTIONS ) {
            return 204;
        }
    }
}