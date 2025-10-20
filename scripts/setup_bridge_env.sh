#!/bin/bash

# ros1_bridge 환경 설정 스크립트
# 환경 변수 완전 초기화 후 ros1_bridge 환경 설정

# 환경 변수 완전 초기화
unset ROS_DISTRO
unset ROS_PACKAGE_PATH
unset ROS_MASTER_URI
unset ROS_ROOT
unset ROS_ETC_DIR
unset ROS_VERSION
unset ROS_PYTHON_VERSION
unset ROS_LOCALHOST_ONLY

# ROS2 환경 설정
source ~/ros2_humble/install/setup.bash

# ros1_bridge 환경 설정
source ~/ros1_bridge/install/setup.bash

# 커스텀 메시지 환경 설정 (선택사항)
if [ -f ~/gap_detect_v1_ws/shared_msgs/install/setup.bash ]; then
    source ~/gap_detect_v1_ws/shared_msgs/install/setup.bash
    echo "✅ 커스텀 메시지 환경 설정 완료"
fi

export ROS_MASTER_URI=http://localhost:11311

echo "✅ ros1_bridge 환경 설정 완료"
echo "ROS_DISTRO: $ROS_DISTRO"
echo "ROS_MASTER_URI: $ROS_MASTER_URI"
