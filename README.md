# Gap Detection Robot System Project

## 🎯 프로젝트 개요

두산 로봇(ROS2 Humble)과 TR200 모바일 로봇(ROS1 Noetic) 간의 협업을 통한 갭 단차 측정 시스템 구축 프로젝트입니다.

## 🏗️ 프로젝트 구조

```
gap_detect_v1_ws/
├── doosan_robot_ws/          # ROS2 워크스페이스 (두산 로봇)
├── tr200_ws/                 # ROS1 워크스페이스 (TR200 모바일 로봇)
├── shared_msgs/              # 공통 메시지 정의
├── config/                   # 설정 파일들
├── launch/                   # 런치 파일들
├── scripts/                  # 빌드/실행 스크립트
└── docs/                     # 프로젝트 문서
```

## 🚀 빠른 시작

### 1. 환경 설정
```bash
# Docker 컨테이너 시작
./scripts/docker_management.sh start

# 전체 시스템 빌드
./scripts/build_all.sh

# 전체 시스템 실행
./scripts/launch_all.sh
```

### 2. 개별 실행
```bash
# ROS1 환경 (모바일 로봇)
cd tr200_ws
source devel/setup.bash
roslaunch tr200_control mobile_robot.launch

# ROS2 환경 (두산 로봇)
cd doosan_robot_ws
source install/setup.bash
ros2 launch dsr_bringup2 dsr_bringup2_rviz.launch.py mode:=virtual model:=a0912
```

## 📋 개발 단계

- [x] 프로젝트 계획 수립
- [ ] 환경 설정 및 기본 통신 구축
- [ ] 두산 로봇 제어 로직 구현
- [ ] 모바일 로봇 제어 로직 구현
- [ ] 통합 시스템 구현
- [ ] 최적화 및 문서화

## 🔧 기술 스택

- **ROS2 Humble**: 두산 로봇 제어
- **ROS1 Noetic**: TR200 모바일 로봇 제어
- **ros1_bridge**: ROS1-ROS2 통신 브리지
- **Docker**: 두산 로봇 에뮬레이터 실행 환경

## 📊 하드웨어

- **두산 로봇**: A0912 모델 (Docker 에뮬레이터 모드)
- **TR200 모바일 로봇**: 커스텀 모바일 플랫폼

## 📚 문서

- [프로젝트 계획서](gap_detect_v1_project.md)
- [ROS1-ROS2 브리지 가이드](Noetic_Humble_bridge_guide.md)
- [두산 로봇 설치 가이드](README_doosan_robot.md)

## 🤝 기여

이 프로젝트는 KATECH의 로봇 자동화 연구를 위한 프로젝트입니다.

## 📄 라이선스

이 프로젝트는 연구 목적으로 개발되었습니다.
