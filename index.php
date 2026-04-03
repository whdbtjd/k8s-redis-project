<?php
$redis = new Redis();
try {
    $redis->connect('redis-service', 6379);
    $count = $redis->incr('visit_count');
    echo "<h1>현재까지 총 방문 횟수: " . $count . "회</h1>";
} catch (Exception $e) {
    echo "Redis 연결 실패: " . $e->getMessage();
}
?>
