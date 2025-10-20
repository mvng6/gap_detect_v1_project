#!/bin/bash

# ROS2 환경 설정 스크립트
# 환경 변수 완전 초기화 후 ROS2 환경만 설정

# 모든 ROS 관련 환경 변수 완전 초기화
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

# 기존 PATH에서 ROS1 관련 경로 제거
export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/opt/ros/noetic' | grep -v '/home/ldj/noetic_ws' | tr '\n' ':' | sed 's/:$//')

# 기존 PYTHONPATH에서 ROS1 관련 경로 제거  
export PYTHONPATH=$(echo $PYTHONPATH | tr ':' '\n' | grep -v '/opt/ros/noetic' | grep -v '/home/ldj/noetic_ws' | tr '\n' ':' | sed 's/:$//')

# ROS2 환경 설정
source ~/ros2_humble/install/setup.bash

# 프로젝트 ROS2 메시지 패키지 환경 설정
source ~/gap_detect_v1_ws/shared_msgs/install/setup.bash

# 두산 로봇 워크스페이스 환경 설정
source ~/gap_detect_v1_ws/doosan_robot_ws/install/setup.bash

echo "✅ ROS2 환경 설정 완료"
echo "ROS_DISTRO: $ROS_DISTRO"
echo "📦 두산 로봇 패키지 로드됨"
