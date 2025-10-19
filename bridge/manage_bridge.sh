#!/bin/bash

# ROS1-ROS2 Bridge 관리 스크립트
# 갭 측정 시스템용 브리지 제어

set -e

BRIDGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$BRIDGE_DIR")"

echo "🌉 ROS1-ROS2 Bridge 관리 스크립트"
echo "프로젝트 루트: $PROJECT_ROOT"
echo "브리지 디렉토리: $BRIDGE_DIR"

# 함수 정의
start_bridge() {
    echo "🚀 브리지 서비스 시작..."
    cd "$BRIDGE_DIR"
    
    # 기존 ros1_bridge 환경 확인
    if [ ! -d "$HOME/ros1_bridge" ]; then
        echo "❌ 기존 ros1_bridge 워크스페이스를 찾을 수 없습니다."
        echo "   ~/ros1_bridge 디렉토리가 존재하는지 확인하세요."
        exit 1
    fi
    
    # 프로젝트 워크스페이스 확인
    if [ ! -d "$PROJECT_ROOT/tr200_ws" ] || [ ! -d "$PROJECT_ROOT/shared_msgs" ]; then
        echo "❌ 프로젝트 워크스페이스를 찾을 수 없습니다."
        echo "   먼저 ./scripts/build_msgs.sh를 실행하세요."
        exit 1
    fi
    
    # Docker Compose로 브리지 시작
    docker compose up -d
    
    echo "✅ 브리지 서비스 시작 완료!"
    echo "   컨테이너 상태 확인: docker ps"
    echo "   로그 확인: docker logs gap_detect_bridge_v1"
}

stop_bridge() {
    echo "🛑 브리지 서비스 중지..."
    cd "$BRIDGE_DIR"
    docker compose down
    echo "✅ 브리지 서비스 중지 완료!"
}

restart_bridge() {
    echo "🔄 브리지 서비스 재시작..."
    stop_bridge
    sleep 2
    start_bridge
}

show_logs() {
    echo "📋 브리지 로그 확인..."
    docker logs -f gap_detect_bridge_v1
}

show_status() {
    echo "📊 브리지 상태 확인..."
    echo ""
    echo "컨테이너 상태:"
    docker ps --filter "name=gap_detect_bridge"
    echo ""
    echo "네트워크 상태:"
    echo "ROS1 Master: http://localhost:11311"
    echo "ROS2 Domain ID: 0"
    echo ""
    echo "토픽 상태:"
    echo "ROS1 토픽:"
    timeout 5 rostopic list 2>/dev/null || echo "ROS1 Master에 연결할 수 없습니다."
    echo ""
    echo "ROS2 토픽:"
    timeout 5 ros2 topic list 2>/dev/null || echo "ROS2 Daemon에 연결할 수 없습니다."
}

test_communication() {
    echo "🧪 브리지 통신 테스트..."
    
    # ROS1 Talker 시작 (백그라운드)
    echo "ROS1 Talker 시작..."
    docker exec -d gap_detect_bridge_v1 bash -c "
        source /opt/ros/noetic/setup.bash &&
        source /workspace/tr200_ws/devel/setup.bash &&
        rostopic pub /test_topic std_msgs/String 'data: \"Hello from ROS1\"' -r 1
    " &
    
    # ROS2 Listener 시작
    echo "ROS2 Listener 시작..."
    docker exec gap_detect_bridge_v1 bash -c "
        source /opt/ros/humble/setup.bash &&
        source /workspace/ros1_bridge/install/setup.bash &&
        timeout 10 ros2 topic echo /test_topic
    " || echo "통신 테스트 완료"
    
    echo "✅ 통신 테스트 완료!"
}

# 메인 로직
case "${1:-}" in
    start)
        start_bridge
        ;;
    stop)
        stop_bridge
        ;;
    restart)
        restart_bridge
        ;;
    logs)
        show_logs
        ;;
    status)
        show_status
        ;;
    test)
        test_communication
        ;;
    *)
        echo "사용법: $0 {start|stop|restart|logs|status|test}"
        echo ""
        echo "명령어 설명:"
        echo "  start   - 브리지 서비스 시작"
        echo "  stop    - 브리지 서비스 중지"
        echo "  restart - 브리지 서비스 재시작"
        echo "  logs    - 브리지 로그 확인"
        echo "  status  - 브리지 상태 확인"
        echo "  test    - 브리지 통신 테스트"
        exit 1
        ;;
esac
