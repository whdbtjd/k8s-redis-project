# 1. 베이스 이미지 선택 (가벼운 Nginx 사용)
FROM nginx:alpine

# 2. 간단한 텍스트를 index.html에 넣기 (빌드 확인용)
RUN echo "<h1>K8s Redis Project Build #1 asdfasdfdsf!</h1>" > /usr/share/nginx/html/index.html

# 3. 80번 포트 개방
EXPOSE 80
