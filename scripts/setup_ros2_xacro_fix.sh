#!/bin/bash

# ROS2 xacro 강제 사용 환경 설정 스크립트
# ROS1 xacro 대신 ROS2 xacro를 강제로 사용

echo "🚀 ROS2 xacro 강제 사용 환경 설정 시작..."

# 모든 ROS 관련 환경 변수 완전 제거
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

# 기본 PATH 설정 (ROS2 xacro 우선 사용)
export PATH=/opt/ros/humble/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 모든 환경 변수 완전 초기화
export PYTHONPATH=""
export LD_LIBRARY_PATH=""

echo "🧹 환경 완전 초기화 완료"

# ROS2 환경 설정
echo "📦 ROS2 환경 설정 중..."
source /opt/ros/humble/setup.bash

# 프로젝트 ROS2 메시지 패키지 환경 설정
echo "📦 프로젝트 메시지 패키지 설정 중..."
source ~/gap_detect_v1_ws/shared_msgs/install/setup.bash

# 두산 로봇 워크스페이스 환경 설정
echo "🤖 두산 로봇 워크스페이스 설정 중..."
source ~/gap_detect_v1_ws/doosan_robot_ws/install/setup.bash

echo ""
echo "✅ ROS2 xacro 강제 사용 환경 설정 완료!"
echo "ROS_DISTRO: $ROS_DISTRO"
echo "📦 두산 로봇 패키지 로드됨"
echo "xacro 위치: $(which xacro)"
echo "xacro 버전: $(xacro --version)"
echo ""
echo "🎯 이제 두산 로봇 명령어를 실행할 수 있습니다:"
echo "ros2 launch dsr_bringup2 dsr_bringup2_gazebo.launch.py mode:=real host:=192.168.137.100 model:=a0912"
echo ""
