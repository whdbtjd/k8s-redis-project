FROM php:8.1-fpm-alpine

# Redis 확장 모듈 설치 및 Nginx 설정
RUN apk add --no-cache nginx \
    && docker-php-ext-install bcmath \
    && pecl install redis \
    && docker-php-ext-enable redis

# Nginx 설정 파일 복사 (없으면 기본값 사용)
COPY index.php /var/www/html/index.php

# 실행 권한 및 포트 설정
EXPOSE 80

# Nginx와 PHP-FPM을 같이 띄우는 실행 명령
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
