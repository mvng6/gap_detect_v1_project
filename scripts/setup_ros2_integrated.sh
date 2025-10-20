#!/bin/bash

# 통합 ROS2 환경 설정 스크립트
# 환경 초기화 + ROS2 설정을 한 번에 수행

echo "🚀 통합 ROS2 환경 설정 시작..."

# 1단계: 강력한 환경 초기화
source ~/gap_detect_v1_ws/scripts/clean_ros_env_strong.sh

# 2단계: ROS2 환경 설정
echo "📦 ROS2 환경 설정 중..."
source ~/ros2_humble/install/setup.bash

# 3단계: 프로젝트 메시지 패키지 설정
echo "📦 프로젝트 메시지 패키지 설정 중..."
source ~/gap_detect_v1_ws/shared_msgs/install/setup.bash

# 4단계: 두산 로봇 워크스페이스 설정
echo "🤖 두산 로봇 워크스페이스 설정 중..."
source ~/gap_detect_v1_ws/doosan_robot_ws/install/setup.bash

echo ""
echo "✅ 통합 ROS2 환경 설정 완료!"
echo "ROS_DISTRO: $ROS_DISTRO"
echo "📦 두산 로봇 패키지 로드됨"
echo "xacro 위치: $(which xacro)"
echo ""
echo "🎯 이제 두산 로봇 명령어를 실행할 수 있습니다:"
echo "ros2 launch dsr_bringup2 dsr_bringup2_gazebo.launch.py mode:=real host:=192.168.137.100 model:=a0912"
echo ""
