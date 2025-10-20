#!/bin/bash

# 전체 시스템 빌드 스크립트
# 갭 측정 시스템의 모든 컴포넌트를 빌드합니다.

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "🔨 전체 시스템 빌드 스크립트"
echo "프로젝트 루트: $PROJECT_ROOT"

# 함수 정의
build_shared_messages() {
    echo "📦 공통 메시지 패키지 빌드 중..."
    cd "$PROJECT_ROOT"
    ./scripts/build_msgs.sh
    echo "✅ 공통 메시지 패키지 빌드 완료!"
}

build_doosan_robot() {
    echo "🤖 두산 로봇 패키지 빌드 중..."
    cd "$PROJECT_ROOT/doosan_robot_ws"
    
    # ROS2 환경 설정
    source ~/ros2_humble/install/setup.bash
    
    # 빌드 실행
    colcon build --packages-skip dsr_tests
    
    echo "✅ 두산 로봇 패키지 빌드 완료!"
}

build_tr200_robot() {
    echo "🚗 TR200 모바일 로봇 패키지 빌드 중..."
    cd ~/noetic_ws
    
    # 기존 noetic_ws 환경 설정
    source ~/noetic_ws/install_isolated/setup.bash
    
    # 빌드 실행
    catkin_make_isolated
    
    echo "✅ TR200 모바일 로봇 패키지 빌드 완료!"
}

show_build_status() {
    echo "📊 빌드 상태 확인..."
    echo ""
    echo "ROS1 패키지 빌드 상태:"
    if [ -d "$HOME/noetic_ws/install_isolated" ]; then
        echo "  ✅ noetic 워크스페이스 빌드 완료"
        ls -la "$HOME/noetic_ws/install_isolated/lib/" | head -5
    else
        echo "  ❌ noetic 워크스페이스 빌드 실패"
    fi
    echo ""
    echo "ROS2 패키지 빌드 상태:"
    if [ -d "$PROJECT_ROOT/shared_msgs/install" ]; then
        echo "  ✅ 공통 메시지 패키지 빌드 완료"
        ls -la "$PROJECT_ROOT/shared_msgs/install/" | head -5
    else
        echo "  ❌ 공통 메시지 패키지 빌드 실패"
    fi
    echo ""
    if [ -d "$PROJECT_ROOT/doosan_robot_ws/install" ]; then
        echo "  ✅ 두산 로봇 패키지 빌드 완료"
        ls -la "$PROJECT_ROOT/doosan_robot_ws/install/" | head -5
    else
        echo "  ❌ 두산 로봇 패키지 빌드 실패"
    fi
}

clean_build() {
    echo "🧹 빌드 캐시 정리 중..."
    
    # ROS1 빌드 캐시 정리
    if [ -d "$HOME/noetic_ws/build_isolated" ]; then
        rm -rf "$HOME/noetic_ws/build_isolated"
        rm -rf "$HOME/noetic_ws/install_isolated"
        echo "ROS1 빌드 캐시 정리 완료"
    fi
    
    # ROS2 빌드 캐시 정리
    if [ -d "$PROJECT_ROOT/shared_msgs/build" ]; then
        rm -rf "$PROJECT_ROOT/shared_msgs/build"
        rm -rf "$PROJECT_ROOT/shared_msgs/install"
        rm -rf "$PROJECT_ROOT/shared_msgs/log"
        echo "공통 메시지 빌드 캐시 정리 완료"
    fi
    
    if [ -d "$PROJECT_ROOT/doosan_robot_ws/build" ]; then
        rm -rf "$PROJECT_ROOT/doosan_robot_ws/build"
        rm -rf "$PROJECT_ROOT/doosan_robot_ws/install"
        rm -rf "$PROJECT_ROOT/doosan_robot_ws/log"
        echo "두산 로봇 빌드 캐시 정리 완료"
    fi
    
    echo "✅ 빌드 캐시 정리 완료!"
}

# 메인 로직
case "${1:-all}" in
    messages)
        build_shared_messages
        ;;
    doosan)
        build_doosan_robot
        ;;
    tr200)
        build_tr200_robot
        ;;
    clean)
        clean_build
        ;;
    status)
        show_build_status
        ;;
    all)
        echo "🔨 전체 시스템 빌드 시작..."
        build_shared_messages
        build_tr200_robot
        build_doosan_robot
        show_build_status
        echo "✅ 전체 시스템 빌드 완료!"
        ;;
    *)
        echo "사용법: $0 {messages|doosan|tr200|clean|status|all}"
        echo ""
        echo "명령어 설명:"
        echo "  messages - 공통 메시지 패키지만 빌드"
        echo "  doosan   - 두산 로봇 패키지만 빌드"
        echo "  tr200    - TR200 모바일 로봇 패키지만 빌드"
        echo "  clean    - 빌드 캐시 정리"
        echo "  status   - 빌드 상태 확인"
        echo "  all      - 모든 컴포넌트 빌드 (기본값)"
        exit 1
        ;;
esac
