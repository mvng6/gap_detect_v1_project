#!/bin/bash
echo "🚀 완전히 깨끗한 ROS2 환경 설정 (최종 버전)"
echo "============================================="

# 현재 쉘의 모든 환경 변수 백업
echo "📋 현재 환경 변수 백업 중..."

# 모든 ROS 관련 환경 변수 완전 제거
echo "🧹 ROS 환경 변수 완전 제거 중..."
unset ROS_DISTRO
unset ROS_PACKAGE_PATH
unset ROS_MASTER_URI
unset ROS_ROOT
unset ROS_ETC_DIR
unset ROS_VERSION
unset ROS_PYTHON_VERSION
unset ROS_LOCALHOST_ONLY
unset ROS_HOSTNAME
unset ROS_IP
unset ROS_NAMESPACE
unset ROSCONSOLE_CONFIG_FILE
unset ROSCONSOLE_FORMAT
unset ROS_PYTHON_LOG_CONFIG_FILE
unset ROS_LOG_DIR
unset ROS_HOME
unset ROS_WORKSPACE
unset AMENT_PREFIX_PATH
unset CMAKE_PREFIX_PATH
unset LD_LIBRARY_PATH
unset PKG_CONFIG_PATH
unset PYTHONPATH
unset ROSLISP_PACKAGE_DIRECTORIES

# PATH에서 ROS1 관련 경로 제거
echo "🔧 PATH에서 ROS1 경로 제거 중..."
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# PYTHONPATH 완전 초기화
export PYTHONPATH=""

# LD_LIBRARY_PATH 완전 초기화  9
export LD_LIBRARY_PATH=""

echo "✅ 환경 초기화 완료"

# ROS2 Humble 환경 설정
echo "📦 ROS2 Humble 환경 설정 중..."
source /opt/ros/humble/setup.bash

# 프로젝트 메시지 패키지 설정
echo "📦 프로젝트 메시지 패키지 설정 중..."
source ~/gap_detect_v1_ws/shared_msgs/install/setup.bash

# 두산 로봇 워크스페이스 설정
echo "🤖 두산 로봇 워크스페이스 설정 중..."
source ~/gap_detect_v1_ws/doosan_robot_ws/install/setup.bash

echo ""
echo "🎉 완전히 깨끗한 ROS2 환경 설정 완료!"
echo "====================================="
echo "ROS_DISTRO: $ROS_DISTRO"
echo "ROS_VERSION: $ROS_VERSION"
echo "xacro 위치: $(which xacro)"
echo "PYTHONPATH 길이: ${#PYTHONPATH}"
echo ""
echo "🔍 환경 변수 검증:"
echo "ROS_PACKAGE_PATH가 ROS1 경로를 포함하는지 확인:"
if [[ "$ROS_PACKAGE_PATH" == *"noetic"* ]]; then
    echo "❌ 경고: ROS_PACKAGE_PATH에 ROS1 경로가 포함되어 있습니다!"
    echo "ROS_PACKAGE_PATH: $ROS_PACKAGE_PATH"
else
    echo "✅ ROS_PACKAGE_PATH가 깨끗합니다"
fi

echo ""
echo "🎯 이제 두산 로봇 명령어를 실행할 수 있습니다:"
echo "ros2 launch dsr_bringup2 dsr_bringup2_rviz.launch.py mode:=real host:=192.168.137.100 port:=12345 model:=a0912"
echo ""
echo "💡 만약 여전히 연결이 안 된다면:"
echo "1. 로봇 컨트롤러에서 TCP/IP 서비스 활성화 확인"
echo "2. 로봇 전원 재시작"
echo "3. 가상 모드로 먼저 테스트: mode:=virtual host:=127.0.0.1"
echo ""
