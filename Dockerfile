FROM php:8.1-fpm-bullseye

# 데비안 계열(apt)은 알파인(apk)보다 네트워크 호환성이 훨씬 좋습니다.
RUN apt-get update && apt-get install -y \
    nginx \
    && docker-php-ext-install bcmath \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && rm -rf /var/lib/apt/lists/*

RUN rm /var/www/html/index.nginx-debian.html || true
# 소스 코드 복사
COPY index.php /var/www/html/index.php

RUN sed -i 's/index index.html index.htm;/index index.php index.html index.htm;/' /etc/nginx/sites-available/default

EXPOSE 80

# 실행 명령 (동일)
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
