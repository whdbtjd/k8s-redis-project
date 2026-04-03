<?php
$redis = new Redis();
try {
    // [수정]: 서비스 이름과 포트를 명확히 기입
    // 만약 redis-service가 안 된다면 'redis-service.default.svc.cluster.local'을 써보세요.
    $redis->connect('redis-service', 6379);
    
    $count = $redis->incr('visit_count');
    echo "<h1>현재까지 총 방문 횟수: " . $count . "회</h1>";
} catch (Exception $e) {
    echo "<h1>Redis 연결 실패: " . $e->getMessage() . "</h1>";
}
?>
