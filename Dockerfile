FROM php:8.1-fpm-bullseye

# 패키지 설치
RUN apt-get update && apt-get install -y \
    nginx \
    && docker-php-ext-install bcmath \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && rm -rf /var/lib/apt/lists/*

# [수정]: Nginx 설정 파일 직접 교체 (403 에러 방지)
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    root /var/www/html; \
    index index.php index.html; \
    location / { \
        try_files $uri $uri/ /index.php?$query_string; \
    } \
    location ~ \.php$ { \
        include snippets/fastcgi-php.conf; \
        fastcgi_pass 127.0.0.1:9000; \
    } \
}' > /etc/nginx/sites-available/default

# 소스 코드 복사 및 권한 부여
COPY index.php /var/www/html/index.php
RUN chmod 644 /var/www/html/index.php && chown www-data:www-data /var/www/html/index.php

EXPOSE 80

# 실행 명령
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
