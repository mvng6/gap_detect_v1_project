#!/bin/bash

# ROS1 환경 설정 스크립트
# 환경 변수 완전 초기화 후 ROS1 환경만 설정

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

# 기존 PATH에서 ROS2 관련 경로 제거
export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/opt/ros/humble' | grep -v '/home/ldj/ros2_humble' | tr '\n' ':' | sed 's/:$//')

# 기존 PYTHONPATH에서 ROS2 관련 경로 제거
export PYTHONPATH=$(echo $PYTHONPATH | tr ':' '\n' | grep -v '/opt/ros/humble' | grep -v '/home/ldj/ros2_humble' | tr '\n' ':' | sed 's/:$//')

# ROS1 환경 설정
source ~/noetic_ws/install_isolated/setup.bash
export ROS_MASTER_URI=http://localhost:11311

echo "✅ ROS1 환경 설정 완료"
echo "ROS_DISTRO: $ROS_DISTRO"
echo "ROS_MASTER_URI: $ROS_MASTER_URI"
