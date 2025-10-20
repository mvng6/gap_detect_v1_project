#!/bin/bash

# 공통 메시지 빌드 스크립트
# ROS1과 ROS2 메시지 패키지를 빌드합니다.

set -e

echo "🔧 Building shared message packages..."

# 환경 변수 초기화 (ROS1과 ROS2 환경 충돌 방지)
unset ROS_DISTRO
unset ROS_PACKAGE_PATH
unset ROS_MASTER_URI

# ROS1 메시지 빌드 (기존 noetic_ws 활용)
echo "📦 Building ROS1 message packages..."
echo "   위치: ~/noetic_ws/src/"
echo "   환경: ~/noetic_ws/install_isolated/setup.bash"
cd ~/noetic_ws

# ROS1 환경 설정 후 빌드
source ~/noetic_ws/install_isolated/setup.bash
export ROS_MASTER_URI=http://localhost:11311
catkin_make_isolated

# 환경 변수 재초기화
unset ROS_DISTRO
unset ROS_PACKAGE_PATH
unset ROS_MASTER_URI

# ROS2 메시지 빌드 (프로젝트 내부 shared_msgs)
echo "📦 Building ROS2 message packages..."
echo "   위치: ~/gap_detect_v1_ws/shared_msgs/"
echo "   환경: ~/ros2_humble/install/setup.bash"
cd ~/gap_detect_v1_ws/shared_msgs
source ~/ros2_humble/install/setup.bash
colcon build --packages-select gap_detection_msgs robot_coordination_msgs

echo "✅ Message package build completed!"
echo ""
echo "📋 Build Results:"
echo "ROS1 Messages (기존 noetic_ws):"
echo "  - gap_detection_msgs: 4 messages, 2 services"
echo "  - robot_coordination_msgs: 3 messages, 2 services"
echo ""
echo "ROS2 Messages (프로젝트 내부 shared_msgs):"
echo "  - gap_detection_msgs: 4 messages, 2 services, 1 action"
echo "  - robot_coordination_msgs: 3 messages, 2 services"
echo ""
echo "🔧 환경 소싱 방법:"
echo "ROS1: source ~/noetic_ws/install_isolated/setup.bash"
echo "ROS2: source ~/gap_detect_v1_ws/shared_msgs/install/setup.bash"
