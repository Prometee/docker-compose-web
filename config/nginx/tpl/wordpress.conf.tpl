server {

    listen 80;
    listen 443 ssl http2;

    root ${NGINX_ROOT}/${NGINX_WEB_FOLDER};

    ssl_certificate /etc/ssl/certs/server-localhost.crt;
    ssl_certificate_key /etc/ssl/private/server-localhost.key;

    ssl_session_cache  builtin:1000  shared:SSL:10m;
    ssl_protocols  TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers HIGH:!aNULL:!eNULL:!EXPORT:!CAMELLIA:!DES:!MD5:!PSK:!RC4;
    ssl_prefer_server_ciphers on;
    
    index ${NGINX_WEB_INDEX_FILE};

    location / {
        try_files ${DOLLAR}uri ${DOLLAR}uri/ /${NGINX_WEB_INDEX_FILE}${DOLLAR}is_args${DOLLAR}args;
    }

    location ~ ^(.+\.php)(/|$) {
        try_files ${DOLLAR}uri =404;
        fastcgi_pass ${NGINX_PHP_FASTCGI_PASS};
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        fastcgi_index ${NGINX_WEB_INDEX_FILE};
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME ${DOLLAR}realpath_root${DOLLAR}fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT ${DOLLAR}realpath_root;
        fastcgi_read_timeout 601; # php max_execution_time + 1 to display errors
    }
}
