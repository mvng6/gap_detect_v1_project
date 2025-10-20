#!/bin/bash

# 안전한 ROS2 환경 설정 스크립트
# 터미널이 종료되지 않도록 exec bash 제거

echo "🚀 ROS2 환경 설정 중..."

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

# 기본 PATH 설정 (ROS 관련 경로 제외)
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# ROS2 환경 설정
source ~/ros2_humble/install/setup.bash

# 프로젝트 ROS2 메시지 패키지 환경 설정
source ~/gap_detect_v1_ws/shared_msgs/install/setup.bash

# 두산 로봇 워크스페이스 환경 설정
source ~/gap_detect_v1_ws/doosan_robot_ws/install/setup.bash

echo "✅ ROS2 환경 설정 완료"
echo "ROS_DISTRO: $ROS_DISTRO"
echo "📦 두산 로봇 패키지 로드됨"
echo "xacro 위치: $(which xacro)"

# 사용자에게 명령어 실행 가능 상태임을 알림
echo ""
echo "🎯 이제 두산 로봇 명령어를 실행할 수 있습니다:"
echo "ros2 launch dsr_bringup2 dsr_bringup2_gazebo.launch.py mode:=real host:=192.168.137.100 model:=a0912"
echo ""
