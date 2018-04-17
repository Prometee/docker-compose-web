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

    location / {
        # try to serve file directly, fallback to index.php
        try_files ${DOLLAR}uri /${NGINX_WEB_INDEX_FILE}${DOLLAR}is_args${DOLLAR}args;
    }
    location ~ ^/${NGINX_WEB_INDEX_FILE_DOT_ESCAPED}(/|$) {
        #resolver 127.0.0.11;
        #set ${DOLLAR}upstream_host app;
        #fastcgi_pass ${DOLLAR}upstream_host:9000;
        # Uncomment the previous lines and comment the next one to enable dynamic resolution (incompatible with Kubernetes)
        fastcgi_pass ${NGINX_PHP_HOST}:${NGINX_PHP_PORT};
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;
        # When you are using symlinks to link the document root to the
        # current version of your application, you should pass the real
        # application path instead of the path to the symlink to PHP
        # FPM.
        # Otherwise, PHP's OPcache may not properly detect changes to
        # your PHP files (see https://github.com/zendtech/ZendOptimizerPlus/issues/126
        # for more information).
        fastcgi_param SCRIPT_FILENAME ${DOLLAR}realpath_root${DOLLAR}fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT ${DOLLAR}realpath_root;
        # Prevents URIs that include the front controller. This will 404:
        # http://domain.tld/index.php/some-path
        # Remove the internal directive to allow URIs like this
        internal;
    }
}
