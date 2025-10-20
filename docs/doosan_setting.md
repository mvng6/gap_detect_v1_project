# Doosan Robot Package Installation Guide

## 🎯 개요
이 가이드는 호스트 시스템에서 두산 로봇 패키지를 설치하는 과정을 단계별로 설명합니다.

## 📋 사전 요구사항
- Ubuntu 22.04 LTS
- ROS2 Humble 설치됨
- Git 설치됨
- Docker 설치됨 (에뮬레이터용)

## 🔧 설치 과정

### 1단계: 필수 의존성 설치
```bash
# 시스템 업데이트
sudo apt-get update

# 필수 의존성 패키지 설치
sudo apt-get install -y libpoco-dev libyaml-cpp-dev wget \
                        ros-humble-control-msgs ros-humble-realtime-tools ros-humble-xacro \
                        ros-humble-joint-state-publisher-gui ros-humble-ros2-control \
                        ros-humble-ros2-controllers ros-humble-gazebo-msgs ros-humble-moveit-msgs \
                        dbus-x11 ros-humble-moveit-configs-utils ros-humble-moveit-ros-move-group \
                        ros-humble-gazebo-ros-pkgs ros-humble-ros-gz-sim ros-humble-ign-ros2-control
```

### 2단계: Gazebo 시뮬레이션 설치
```bash
# Gazebo 저장소 추가
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'

# Gazebo 키 추가
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -

# 패키지 목록 업데이트
sudo apt-get update

# Gazebo 시뮬레이션 패키지 설치
sudo apt-get install -y libignition-gazebo6-dev ros-humble-gazebo-ros-pkgs ros-humble-ros-gz-sim ros-humble-ros-gz
```

### 3단계: 워크스페이스 디렉토리로 이동
```bash
cd ~/gap_detect_v1_ws/doosan_robot_ws/src
```

### 4단계: 두산 로봇 패키지 클론
```bash
git clone -b humble https://github.com/doosan-robotics/doosan-robot2.git
```

### 5단계: 패키지 의존성 설치
```bash
# 워크스페이스 루트로 이동
cd ~/gap_detect_v1_ws/doosan_robot_ws

# 패키지 의존성 설치
rosdep install -r --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y
```

### 6단계: 에뮬레이터 설치 스크립트 실행
```bash
# 두산 로봇 패키지 디렉토리로 이동
cd ~/gap_detect_v1_ws/doosan_robot_ws/src/doosan-robot2

# 에뮬레이터 설치 스크립트 실행 권한 부여
chmod +x ./install_emulator.sh

# 에뮬레이터 설치 스크립트 실행
sudo ./install_emulator.sh
```

### 7단계: 패키지 빌드
```bash
# 워크스페이스 루트로 이동
cd ~/gap_detect_v1_ws/doosan_robot_ws

# ROS2 환경 설정 후 빌드
source /opt/ros/humble/setup.bash
colcon build
```

### 8단계: 환경 설정
```bash
# ROS2 환경 설정
source /opt/ros/humble/setup.bash

# 빌드된 환경 소스
source install/setup.bash
```

## 🐳 에뮬레이터 설정

### 에뮬레이터 실행
```bash
# 두산 로봇 에뮬레이터 실행 (호스트 시스템에서 직접 실행)
# 에뮬레이터는 두산 로봇 패키지 설치 시 자동으로 설치됨
# 가상 모드로 실행 시 자동으로 에뮬레이터가 시작됨
```

## 🧪 기본 동작 테스트

### Rviz2를 통한 시각화 테스트
```bash
# 환경 설정
cd ~/gap_detect_v1_ws/doosan_robot_ws
source ~/ros2_humble/install/setup.bash
source install/setup.bash

# 가상 모드로 Rviz2 실행
ros2 launch dsr_bringup2 dsr_bringup2_rviz.launch.py mode:=virtual host:=127.0.0.1 port:=12345 model:=a0912
```

### Gazebo 시뮬레이션 테스트
```bash
# 환경 설정
cd ~/gap_detect_v1_ws/doosan_robot_ws
source ~/ros2_humble/install/setup.bash
source install/setup.bash

# 가상 모드로 Gazebo 실행
ros2 launch dsr_bringup2 dsr_bringup2_gazebo.launch.py mode:=virtual host:=127.0.0.1 port:=12345 model:=a0912
```

## 🔍 설치 확인

### 패키지 설치 확인
```bash
# ROS2 환경 설정
source ~/ros2_humble/install/setup.bash
source ~/gap_detect_v1_ws/doosan_robot_ws/install/setup.bash

# ROS2 패키지 목록 확인
ros2 pkg list | grep dsr

# 노드 목록 확인
ros2 node list
```

### 토픽 확인
```bash
# ROS2 환경 설정
source ~/ros2_humble/install/setup.bash
source ~/gap_detect_v1_ws/doosan_robot_ws/install/setup.bash

# 토픽 목록 확인
ros2 topic list

# 특정 토픽 정보 확인
ros2 topic info /dsr/joint_states
```

## ⚠️ 주의사항

1. **ROS2 환경 설정**: 모든 명령어 실행 전에 `source ~/ros2_humble/install/setup.bash`를 실행해야 합니다.
2. **포트 충돌**: 포트 12345가 이미 사용 중인 경우 다른 포트를 사용하세요.
3. **모델 설정**: A0912 모델을 사용하므로 `model:=a0912` 파라미터를 반드시 포함하세요.
4. **네트워크 설정**: 가상 모드에서는 `host:=127.0.0.1`을 사용합니다.

## 🚨 문제 해결

### 일반적인 문제들

#### 1. ROS2 환경 설정 문제
```bash
# ROS2 환경이 설정되지 않은 경우
source ~/ros2_humble/install/setup.bash

# 환경 변수 확인
echo $ROS_DISTRO

# 빌드 시 ROS2 환경 설정
cd ~/gap_detect_v1_ws/doosan_robot_ws
source ~/ros2_humble/install/setup.bash
colcon build
```

#### 2. 의존성 설치 실패
```bash
# rosdep 업데이트
sudo rosdep init
rosdep update

# 개별 패키지 설치
sudo apt-get update
sudo apt-get install -y libpoco-dev libyaml-cpp-dev wget
```

#### 3. 빌드 실패
```bash
# 빌드 캐시 정리
rm -rf build/ install/ log/

# ROS2 환경 설정 후 다시 빌드
source ~/ros2_humble/install/setup.bash
colcon build
```

#### 4. 에뮬레이터 실행 실패
```bash
# 에뮬레이터 재설치
cd ~/gap_detect_v1_ws/doosan_robot_ws/src/doosan-robot2
sudo ./install_emulator.sh

# 포트 확인
netstat -tlnp | grep 12345
```

## 📚 추가 정보

- [두산 로봇 공식 ROS2 매뉴얼](https://doosanrobotics.github.io/doosan-robotics-ros-manual/humble/index.html)
- [ROS2 Humble 문서](https://docs.ros.org/en/humble/)

## ✅ 설치 완료 체크리스트

- [ ] 필수 의존성 설치 완료
- [ ] Gazebo 시뮬레이션 설치 완료
- [ ] 두산 로봇 패키지 클론 완료
- [ ] 패키지 의존성 설치 완료
- [ ] 에뮬레이터 설치 스크립트 실행 완료
- [ ] 패키지 빌드 완료
- [ ] 에뮬레이터 실행 완료
- [ ] Rviz2 테스트 완료
- [ ] Gazebo 시뮬레이션 테스트 완료

---

**작성일**: 2024년 12월  
**버전**: 1.0  
**작성자**: Gap Detection Robot System Project Team
