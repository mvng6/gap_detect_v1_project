#!/bin/bash

# 강력한 ROS 환경 초기화 스크립트
# PATH와 PYTHONPATH를 완전히 정리하여 ROS2만 사용

echo "🧹 강력한 ROS 환경 초기화 중..."

# 모든 ROS 관련 환경 변수 제거
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

# PATH에서 모든 ROS 관련 경로 완전 제거 (ROS2 기본 경로는 유지)
export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/home/ldj/noetic_ws' | grep -v '/home/ldj/ros2_humble' | grep -v '/home/ldj/ros1_bridge' | grep -v '/home/ldj/gap_detect_v1_ws' | tr '\n' ':' | sed 's/:$//')

# PYTHONPATH에서 모든 ROS 관련 경로 완전 제거
export PYTHONPATH=$(echo $PYTHONPATH | tr ':' '\n' | grep -v '/opt/ros' | grep -v '/home/ldj/noetic_ws' | grep -v '/home/ldj/ros2_humble' | grep -v '/home/ldj/ros1_bridge' | grep -v '/home/ldj/gap_detect_v1_ws' | tr '\n' ':' | sed 's/:$//')

# LD_LIBRARY_PATH에서 ROS 관련 경로 제거
export LD_LIBRARY_PATH=$(echo $LD_LIBRARY_PATH | tr ':' '\n' | grep -v '/opt/ros' | grep -v '/home/ldj/noetic_ws' | grep -v '/home/ldj/ros2_humble' | grep -v '/home/ldj/ros1_bridge' | tr '\n' ':' | sed 's/:$//')

echo "✅ 환경 초기화 완료"
echo "현재 ROS_DISTRO: $ROS_DISTRO"
echo "현재 PATH 길이: $(echo $PATH | tr ':' '\n' | wc -l)"
