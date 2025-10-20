#!/bin/bash

# 통신 테스트 스크립트
# ROS1-ROS2 브리지를 통한 커스텀 메시지 송수신 테스트

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "🧪 통신 테스트 스크립트"
echo "프로젝트 루트: $PROJECT_ROOT"

# 함수 정의
check_prerequisites() {
    echo "🔍 사전 요구사항 확인 중..."
    
    # ROS1 Master 확인
    if ! timeout 5 rostopic list >/dev/null 2>&1; then
        echo "❌ ROS1 Master에 연결할 수 없습니다."
        echo "   먼저 roscore를 실행하세요."
        exit 1
    fi
    
    # ROS2 Daemon 확인
    if ! timeout 5 ros2 topic list >/dev/null 2>&1; then
        echo "❌ ROS2 Daemon에 연결할 수 없습니다."
        echo "   먼저 ros2 daemon start를 실행하세요."
        exit 1
    fi
    
    # ros1_bridge 확인
    if ! timeout 5 ros2 node list | grep -q "ros1_bridge"; then
        echo "❌ ros1_bridge가 실행되지 않았습니다."
        echo "   먼저 ros1_bridge를 실행하세요."
        exit 1
    fi
    
    echo "✅ 사전 요구사항 확인 완료!"
}

test_basic_communication() {
    echo "📡 기본 통신 테스트 (std_msgs/String)..."
    
    # ROS1 Talker 시작 (백그라운드)
    echo "ROS1 Talker 시작..."
    rostopic pub /test_basic std_msgs/String "data: 'Hello from ROS1'" -r 1 &
    local talker_pid=$!
    
    # ROS2 Listener 시작
    echo "ROS2 Listener 시작..."
    timeout 10 ros2 topic echo /test_basic || echo "기본 통신 테스트 완료"
    
    # Talker 프로세스 종료
    kill $talker_pid 2>/dev/null || true
    
    echo "✅ 기본 통신 테스트 완료!"
}

test_custom_messages() {
    echo "📡 커스텀 메시지 통신 테스트..."
    
    # SectionArrival 메시지 테스트
    echo "SectionArrival 메시지 테스트..."
    rostopic pub /gap_detection/section_arrival gap_detection_msgs/SectionArrival "
    header:
      stamp: {secs: 0, nsecs: 0}
      frame_id: 'mobile_robot'
    section_number: 1
    robot_pose:
      position: {x: 1.0, y: 2.0, z: 0.0}
      orientation: {x: 0.0, y: 0.0, z: 0.0, w: 1.0}
    is_stopped: true
    status_message: 'Arrived at section 1'
    " -r 0.5 &
    
    local custom_talker_pid=$!
    
    # ROS2 Listener 시작
    echo "ROS2 Listener 시작..."
    timeout 10 ros2 topic echo /gap_detection/section_arrival || echo "커스텀 메시지 테스트 완료"
    
    # Talker 프로세스 종료
    kill $custom_talker_pid 2>/dev/null || true
    
    echo "✅ 커스텀 메시지 통신 테스트 완료!"
}

test_reverse_communication() {
    echo "📡 역방향 통신 테스트 (ROS2 → ROS1)..."
    
    # ROS1 Listener 시작 (백그라운드)
    echo "ROS1 Listener 시작..."
    rostopic echo /gap_detection/measurement_result &
    local listener_pid=$!
    
    # ROS2 Talker 시작
    echo "ROS2 Talker 시작..."
    ros2 topic pub /gap_detection/measurement_result gap_detection_msgs/msg/MeasurementResult "
    header:
      stamp: {sec: 0, nanosec: 0}
      frame_id: 'doosan_robot'
    section_number: 1
    measurement_success: true
    measurement_data: [1.5, 2.3, 0.8]
    measurement_pose:
      position: {x: 0.5, y: 1.0, z: 0.2}
      orientation: {x: 0.0, y: 0.0, z: 0.0, w: 1.0}
    measurement_time: {sec: 0, nanosec: 0}
    error_message: ''
    is_home_position: false
    " -r 0.5 &
    
    local talker_pid=$!
    
    # 10초 대기
    sleep 10
    
    # 프로세스 종료
    kill $listener_pid 2>/dev/null || true
    kill $talker_pid 2>/dev/null || true
    
    echo "✅ 역방향 통신 테스트 완료!"
}

show_topic_info() {
    echo "📋 토픽 정보 확인..."
    echo ""
    echo "ROS1 토픽 목록:"
    timeout 5 rostopic list 2>/dev/null || echo "ROS1 Master에 연결할 수 없습니다."
    echo ""
    echo "ROS2 토픽 목록:"
    timeout 5 ros2 topic list 2>/dev/null || echo "ROS2 Daemon에 연결할 수 없습니다."
    echo ""
    echo "브리지 노드 상태:"
    timeout 5 ros2 node list | grep ros1_bridge || echo "ros1_bridge가 실행되지 않았습니다."
}

# 메인 로직
case "${1:-all}" in
    basic)
        check_prerequisites
        test_basic_communication
        ;;
    custom)
        check_prerequisites
        test_custom_messages
        ;;
    reverse)
        check_prerequisites
        test_reverse_communication
        ;;
    info)
        show_topic_info
        ;;
    all)
        check_prerequisites
        test_basic_communication
        echo ""
        test_custom_messages
        echo ""
        test_reverse_communication
        echo ""
        show_topic_info
        echo "✅ 모든 통신 테스트 완료!"
        ;;
    *)
        echo "사용법: $0 {basic|custom|reverse|info|all}"
        echo ""
        echo "명령어 설명:"
        echo "  basic   - 기본 통신 테스트 (std_msgs/String)"
        echo "  custom  - 커스텀 메시지 통신 테스트"
        echo "  reverse - 역방향 통신 테스트 (ROS2 → ROS1)"
        echo "  info    - 토픽 정보 확인"
        echo "  all     - 모든 테스트 실행 (기본값)"
        echo ""
        echo "사전 요구사항:"
        echo "  1. ROS1 Master 실행: roscore"
        echo "  2. ROS2 Daemon 실행: ros2 daemon start"
        echo "  3. ros1_bridge 실행: ros2 run ros1_bridge dynamic_bridge"
        exit 1
        ;;
esac
