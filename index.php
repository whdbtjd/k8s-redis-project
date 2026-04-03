cat <<EOF > index.php
<?php
header('Content-Type: text/html; charset=utf-8');
\$redis = new Redis();

try {
    // 중요: 서비스 이름인 'redis-service'로 접속합니다.
    \$redis->connect('redis-service', 6379);
    \$count = \$redis->incr('visit_count');
    echo "<h1>[K8s + Redis 프로젝트]</h1>";
    echo "<h2>현재까지 총 방문 횟수: <span style='color:red;'> " . \$count . "</span>회</h2>";
    echo "<p>새로고침을 누를 때마다 숫자가 올라갑니다.</p>";
} catch (Exception \$e) {
    echo "Redis 연결 실패: " . \$e->getMessage();
}
?>
EOF
