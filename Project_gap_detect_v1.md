# Gap Detection Robot System Project (gap_detect_v1_project)

## 🎯 프로젝트 개요

### 목표
- 두산 로봇(ROS2 Humble)과 TR200 모바일 로봇(ROS1 Noetic) 간의 협업을 통한 갭 단차 측정 시스템 구축
- ROS1-ROS2 브리지 통신을 통한 실시간 상태 동기화 및 공정 제어

### 시스템 구성
- **두산 로봇**: 갭 단차 측정 담당 (ROS2 Humble 환경)
- **TR200 모바일 로봇**: 위치 이동 및 구간별 정지 담당 (ROS1 Noetic 환경)
- **통신**: ros1_bridge를 통한 양방향 메시지 교환

## 🔧 환경 설정

### 기존 ROS 환경 활용
- [x] ROS1 Noetic 환경 (`~/noetic_ws`) 활용
- [x] ROS2 Humble 환경 (`~/ros2_humble`) 활용  
- [x] ros1_bridge 환경 (`~/ros1_bridge`) 활용
- [ ] 두산 로봇 에뮬레이터 설치 스크립트 실행

### 환경 소싱 방법
```bash
# ROS1 환경 설정
source ~/noetic_ws/install_isolated/setup.bash
export ROS_MASTER_URI=http://localhost:11311

# ROS2 환경 설정
source ~/ros2_humble/install/setup.bash

# ros1_bridge 환경 설정
source ~/ros1_bridge/install/setup.bash
```

## 🏗️ 프로젝트 디렉토리 구조

### 워크스페이스 구조
```
home/ldj/
├── ros2_humble/                           # 기존 ROS2 Humble 워크스페이스 (참조용)
├── noetic_ws/                             # 기존 ROS1 Noetic 워크스페이스 (참조용)
├── ros1_bridge/                           # 기존 ROS1-ROS2 브리지 (참조용)
└── gap_detect_v1_ws/                      # 프로젝트 전체 관리 최상위 디렉토리
    ├── doosan_robot_ws/                    # ROS2 응용 프로그램 워크스페이스
    │   └── src/
    │       ├── doosan-robot2/             # 두산 로봇 패키지 (기존 메시지/서비스 포함)
    │       ├── gap_detection_controller/  # 두산 로봇 제어 패키지
    │       └── gap_process_manager/        # 전체 프로세스 관리 패키지
    ├── tr200_ws/                          # ROS1 응용 프로그램 워크스페이스 (프로젝트 내부 통합)
    │   └── src/
    │       ├── gap_detection_msgs/         # ROS1 공통 메시지 패키지
    │       ├── robot_coordination_msgs/   # ROS1 공통 메시지 패키지
    │       └── tr200_control/             # TR200 모바일 로봇 제어 패키지
    ├── shared_msgs/                       # ROS2 공통 메시지 정의 디렉토리
    │   ├── gap_detection_msgs/            # ROS2 갭 측정 관련 메시지
    │   └── robot_coordination_msgs/       # ROS2 로봇 간 협업 메시지
    ├── config/                            # 중앙 설정 파일 디렉토리
    │   ├── doosan_robot_config.yaml
    │   ├── mobile_robot_config.yaml
    │   └── bridge_mapping.yaml            # ros1_bridge 메시지 매핑 설정
    ├── launch/                            # 통합 런치 파일 디렉토리
    │   ├── gap_detection_system.launch.py
    │   ├── doosan_robot.launch.py
    │   ├── mobile_robot.launch.py
    │   └── bridge.launch.py
    ├── scripts/                           # 빌드/실행 등 편의 스크립트 디렉토리
    │   ├── build_all.sh                   # 전체 빌드
    │   ├── build_ros2.sh                  # ROS2만 빌드
    │   ├── build_ros1.sh                  # ROS1만 빌드
    │   ├── build_msgs.sh                  # 공통 메시지 빌드
    │   └── test_communication.sh         # 통신 테스트
    └── docs/                              # 프로젝트 문서 디렉토리
        ├── README.md
        ├── API_Documentation.md
        ├── Message_Reference.md           # 메시지 참조 문서
        └── Troubleshooting.md
```

## 📋 개발 단계별 계획

### Phase 1: 환경 설정 및 기본 통신 구축 (1-2주)

#### 1.1 워크스페이스 구조 설정
- [x] `gap_detect_v1_ws` 디렉토리 생성
- [x] ROS2 워크스페이스 초기화 (`doosan_robot_ws/src/` 디렉토리 생성)
- [x] ROS1 워크스페이스 초기화 (`tr200_ws/src/` 디렉토리 생성)
- [x] 공통 메시지 디렉토리 생성 (`shared_msgs/` 디렉토리 생성)
- [x] Docker 디렉토리 생성 (`docker/` 디렉토리 생성)
- [x] 기타 필수 디렉토리 생성 (`config/`, `launch/`, `scripts/`, `docs/`)
- [x] ros1_bridge 워크스페이스 설정 (기존 환경 활용)

#### 1.2 환경 설정
- [x] ROS1 Noetic 환경 확인 (`~/noetic_ws`)
- [x] ROS2 Humble 환경 확인 (`~/ros2_humble`)
- [x] ros1_bridge 환경 확인 (`~/ros1_bridge`)
- [ ] 두산 로봇 에뮬레이터 설치 스크립트 실행
- [ ] TR200 모바일 로봇 시뮬레이터 설정
- [ ] 기본 동작 테스트 (Rviz2, Gazebo 시뮬레이션)

#### 1.3 두산 로봇 패키지 설치
- [x] 두산 로봇 패키지 클론 (`git clone -b humble https://github.com/doosan-robotics/doosan-robot2.git`)
- [x] 의존성 설치 및 빌드
- [x] 기본 동작 테스트 (Rviz2, Gazebo 시뮬레이션)

#### 1.4 공통 메시지 정의 및 브리지 설정
- [x] `gap_detection_msgs` 패키지 생성 (`shared_msgs/gap_detection_msgs`)
- [x] `robot_coordination_msgs` 패키지 생성 (`shared_msgs/robot_coordination_msgs`)
- [x] 메시지 타입 정의:
  - `SectionArrival.msg` (구간 도착 신호)
  - `MeasurementCommand.msg` (측정 명령)
  - `MeasurementResult.msg` (측정 결과)
  - `ProcessComplete.msg` (프로세스 완료 신호)
- [x] ros1_bridge 메시지 매핑 설정 (`config/bridge_mapping.yaml`)
- [x] 기존 두산 로봇 메시지와의 호환성 확인
- [x] ROS1 메시지 패키지 빌드 완료 (기존 noetic_ws 활용)
- [x] ROS2 메시지 패키지 빌드 완료 (ament_cmake_ros 활용)

#### 1.5 빌드 스크립트 작성
- [x] 공통 메시지 빌드 스크립트 작성 (`scripts/build_msgs.sh`)
- [x] 전체 시스템 빌드 스크립트 작성 (`scripts/build_all.sh`)
- [x] 통신 테스트 스크립트 작성 (`scripts/test_communication.sh`)

#### 1.6 기본 통신 테스트
- [x] ROS1-ROS2 브리지 설정 및 테스트 (기존 환경 활용)
- [x] 브리지 환경 설정 완료
- [x] 호스트 시스템에서 dynamic_bridge 실행 성공
- [x] 환경 변수 충돌 해결 및 환경 설정 스크립트 생성
- [x] 기본 메시지 통신 테스트 성공 (std_msgs/String)
- [ ] 커스텀 메시지 송수신 테스트
- [ ] 통신 지연 및 안정성 확인

### Phase 2: 두산 로봇 제어 로직 구현 (2-3주)

#### 2.1 두산 로봇 제어 패키지 개발
- [ ] `gap_detection_controller` 패키지 생성 (`doosan_robot_ws/src/gap_detection_controller`)
- [ ] `gap_process_manager` 패키지 생성 (`doosan_robot_ws/src/gap_process_manager`)
- [ ] 두산 로봇 기존 메시지/서비스 활용 (`dsr_msgs`, `dsr_control2`)
- [ ] 두산 로봇 상태 모니터링 노드 구현
- [ ] 홈 포지션 제어 로직 구현
- [ ] 측정 경로 정의 및 실행 로직 구현

#### 2.2 측정 알고리즘 구현
- [ ] 갭 단차 측정 알고리즘 설계
- [ ] 센서 데이터 처리 로직 구현
- [ ] 측정 결과 데이터 구조 정의
- [ ] 측정 정확도 검증

#### 2.3 상태 관리 시스템
- [ ] 로봇 상태 정의 (IDLE, MOVING, MEASURING, ERROR)
- [ ] 상태 전환 로직 구현
- [ ] 에러 처리 및 복구 메커니즘
- [ ] 안전 장치 구현 (속도/토크 제한)

### Phase 3: 모바일 로봇 제어 로직 구현 (2-3주)

#### 3.1 모바일 로봇 패키지 개발
- [ ] `tr200_control` 패키지 생성 (`tr200_ws/src/tr200_control`)
- [ ] 모바일 로봇 상태 모니터링 노드 구현
- [ ] 구간별 이동 로직 구현 (1구간, 2구간, 3구간)
- [ ] 정지 감지 및 확인 로직 구현

#### 3.2 경로 계획 및 제어
- [ ] 대상 물체 기준 좌표계 설정
- [ ] 구간별 목표 위치 정의
- [ ] 직선 이동 제어 알고리즘 구현
- [ ] 복귀 경로 계획 구현

#### 3.3 통신 인터페이스
- [ ] 두산 로봇과의 메시지 송수신 구현
- [ ] 상태 동기화 로직 구현
- [ ] 대기 및 확인 메커니즘 구현

### Phase 4: 통합 시스템 구현 (2-3주)

#### 4.1 협업 로직 구현
- [ ] 전체 공정 시퀀스 정의
- [ ] 상태 머신 구현
- [ ] 동기화 메커니즘 구현
- [ ] 에러 처리 및 복구 로직

#### 4.2 런치 파일 및 설정
- [ ] 통합 런치 파일 작성
- [ ] 설정 파일 최적화
- [ ] 환경 변수 및 파라미터 관리
- [ ] 로깅 및 모니터링 설정

#### 4.3 테스트 및 검증
- [ ] 단위 테스트 구현
- [ ] 통합 테스트 시나리오 작성
- [ ] 성능 테스트 및 최적화
- [ ] 안전성 검증

### Phase 5: 최적화 및 문서화 (1-2주)

#### 5.1 성능 최적화
- [ ] 통신 지연 최소화
- [ ] 메모리 사용량 최적화
- [ ] CPU 사용률 최적화
- [ ] 실시간 성능 개선

#### 5.2 문서화
- [ ] API 문서 작성
- [ ] 사용자 매뉴얼 작성
- [ ] 트러블슈팅 가이드 작성
- [ ] 코드 주석 및 문서화

## 🔧 빌드 및 실행 가이드

### 빌드 명령어
```bash
# 공통 메시지 빌드 (먼저 빌드 필요)
cd ~/gap_detect_v1_ws
./scripts/build_msgs.sh

# ROS1 패키지 빌드 (기존 noetic_ws 활용)
cd ~/noetic_ws
catkin_make_isolated

# ROS2 패키지 빌드
cd ~/gap_detect_v1_ws/shared_msgs
colcon build

# 두산 로봇 패키지 빌드
cd ~/gap_detect_v1_ws/doosan_robot_ws
colcon build

# 브리지 실행 (호스트 시스템)
cd ~/ros1_bridge
source install/setup.bash
export ROS_MASTER_URI=http://localhost:11311
ros2 run ros1_bridge dynamic_bridge
```

### 환경 설정
```bash
# 환경 설정 스크립트 사용 (권장)
cd ~/gap_detect_v1_ws

# ROS1 환경 설정
source scripts/setup_ros1_env.sh

# ROS2 환경 설정
source scripts/setup_ros2_env.sh

# 브리지 환경 설정 (커스텀 메시지 포함)
source scripts/setup_bridge_env.sh
```

### 수동 환경 설정 (참고용)
```bash
# ROS1 환경 설정 (기존 noetic_ws 활용)
source ~/noetic_ws/install_isolated/setup.bash
export ROS_MASTER_URI=http://localhost:11311

# ROS2 환경 설정 (기존 ros2_humble 활용)
source ~/ros2_humble/install/setup.bash

# 프로젝트 ROS2 메시지 패키지 환경 설정
source ~/gap_detect_v1_ws/shared_msgs/install/setup.bash

# 브리지 환경 설정 (기존 ros1_bridge 활용)
source ~/ros1_bridge/install/setup.bash
export ROS_MASTER_URI=http://localhost:11311
```

## 🔧 기술 스택 및 도구

### ROS 환경
- **ROS2 Humble**: 두산 로봇 제어
- **ROS1 Noetic**: TR200 모바일 로봇 제어
- **ros1_bridge**: ROS1-ROS2 통신 브리지

### 개발 도구
- **언어**: C++17, Python 3.10+
- **빌드 시스템**: CMake, colcon
- **시뮬레이션**: Gazebo, Rviz2
- **버전 관리**: Git

### 하드웨어
- **두산 로봇**: A0912 모델 (에뮬레이터 모드)
- **TR200 모바일 로봇**: 커스텀 모바일 플랫폼

## 📊 통신 아키텍처 (Topic + Action 방식)

### 통신 방식 선택 기준
- **Topic (80%)**: 상태 정보, 이벤트 신호 - 비동기 통신으로 실시간성 보장
- **Action (20%)**: 장시간 작업 제어 - 진행률 피드백 및 취소 가능
- **Service (최소)**: 긴급 정지 등 즉시 응답 필요시에만 사용

### 기존 두산 로봇 메시지 활용
```
# 두산 로봇 기존 메시지/서비스
dsr_msgs/
├── RobotState.msg                    # 로봇 상태 정보
├── MoveRequest.msg                   # 이동 요청
└── ...

dsr_control2/
├── MoveJoint.srv                     # 관절 이동 서비스
├── MoveLine.srv                      # 직선 이동 서비스
└── ...
```

### 커스텀 메시지 (공통)
```
gap_detection_msgs/
├── SectionArrival.msg                # 구간 도착 신호 (Topic)
├── MeasurementResult.msg            # 측정 결과 (Topic)
├── RobotStatus.msg                  # 로봇 상태 정보 (Topic)
└── PerformMeasurement.action        # 측정 작업 (Action)

robot_coordination_msgs/
├── ProcessComplete.msg               # 프로세스 완료 신호 (Topic)
├── SystemStatus.msg                  # 시스템 상태 (Topic)
└── MoveToSection.action             # 구간 이동 작업 (Action)
```

### Topic 기반 통신 (비동기)
```
# ROS1 → ROS2 통신 (모바일 로봇 → 두산 로봇)
/gap_detection/section_arrival        # 구간 도착 신호
/gap_detection/robot_status          # 모바일 로봇 상태

# ROS2 → ROS1 통신 (두산 로봇 → 모바일 로봇)  
/gap_detection/measurement_complete   # 측정 완료 신호
/gap_detection/robot_status          # 두산 로봇 상태
```

### Action 기반 통신 (장시간 작업)
```
# 두산 로봇 측정 작업
/gap_detection/perform_measurement    # 측정 액션 서버
- Goal: 측정 구간 정보
- Feedback: 측정 진행률
- Result: 측정 결과 데이터

# TR200 이동 작업  
/gap_detection/move_to_section        # 이동 액션 서버
- Goal: 목표 구간 번호
- Feedback: 이동 진행률
- Result: 도착 확인
```

## 🚀 실행 시나리오

### 1. 시스템 시작 (환경 설정 스크립트 사용)

**터미널 1 (ROS1 Master):**
```bash
cd ~/gap_detect_v1_ws
source scripts/setup_ros1_env.sh
roscore
```

**터미널 2 (ROS2 Daemon):**
```bash
cd ~/gap_detect_v1_ws
source scripts/setup_ros2_env.sh
ros2 daemon start
```

**터미널 3 (ros1_bridge):**
```bash
cd ~/gap_detect_v1_ws
source scripts/setup_bridge_env.sh
ros2 run ros1_bridge dynamic_bridge
```

### 2. 기본 통신 테스트

**터미널 4 (ROS1 Talker):**
```bash
cd ~/gap_detect_v1_ws
source scripts/setup_ros1_env.sh
rosrun roscpp_tutorials talker
```

**터미널 5 (ROS2 Listener):**
```bash
cd ~/gap_detect_v1_ws
source scripts/setup_ros2_env.sh
ros2 run demo_nodes_cpp listener
```

### 3. 커스텀 메시지 통신 테스트

**터미널 6 (ROS1 Topic 메시지 전송):**
```bash
cd ~/gap_detect_v1_ws
source scripts/setup_ros1_env.sh
rostopic pub /gap_detection/section_arrival gap_detection_msgs/SectionArrival "header: {stamp: {secs: 0, nsecs: 0}, frame_id: 'mobile_robot'}, section_number: 1, robot_pose: {position: {x: 1.0, y: 2.0, z: 0.0}, orientation: {x: 0.0, y: 0.0, z: 0.0, w: 1.0}}, is_stopped: true, status_message: 'Arrived at section 1'" -r 0.5
```

**터미널 7 (ROS2 Topic 메시지 수신):**
```bash
cd ~/gap_detect_v1_ws
source scripts/setup_ros2_env.sh
ros2 topic echo /gap_detection/section_arrival
```

### 4. Action 통신 테스트

**터미널 8 (ROS2 Action 서버 실행):**
```bash
cd ~/gap_detect_v1_ws
source scripts/setup_ros2_env.sh
ros2 run gap_detection_controller measurement_action_server
```

**터미널 9 (ROS1 Action 클라이언트 테스트):**
```bash
cd ~/gap_detect_v1_ws
source scripts/setup_ros1_env.sh
rosrun tr200_control measurement_action_client
```

### 4. 개별 로봇 실행
```bash
# TR200 모바일 로봇 실행
source ~/noetic_ws/install_isolated/setup.bash
export ROS_MASTER_URI=http://localhost:11311
roslaunch tr200_control mobile_robot.launch

# 두산 로봇 실행
source ~/ros2_humble/install/setup.bash
source ~/gap_detect_v1_ws/doosan_robot_ws/install/setup.bash
ros2 launch dsr_bringup2 dsr_bringup2_rviz.launch.py mode:=virtual host:=127.0.0.1 port:=12345 model:=a0912

# 통합 제어 시스템 실행
source ~/ros2_humble/install/setup.bash
source ~/gap_detect_v1_ws/doosan_robot_ws/install/setup.bash
ros2 launch gap_process_manager gap_detection_system.launch.py
```

### 5. 공정 시퀀스 (Topic + Action 방식)

#### Phase 1: 시스템 초기화
1. **Topic**: 시스템 상태 모니터링 시작
2. **Action**: 두산 로봇 홈 포지션 이동 (`/gap_detection/move_to_home`)
3. **Action**: TR200 초기 위치 이동 (`/gap_detection/move_to_section`)

#### Phase 2: 구간별 측정 프로세스 (1-3구간 반복)
1. **Action**: TR200 구간 이동 (`/gap_detection/move_to_section`)
   - Goal: 구간 번호 (1, 2, 3)
   - Feedback: 이동 진행률
2. **Topic**: 구간 도착 신호 발송 (`/gap_detection/section_arrival`)
3. **Action**: 두산 로봇 측정 수행 (`/gap_detection/perform_measurement`)
   - Goal: 측정 구간 정보
   - Feedback: 측정 진행률
4. **Topic**: 측정 완료 신호 발송 (`/gap_detection/measurement_complete`)

#### Phase 3: 공정 완료
1. **Action**: TR200 초기 위치 복귀 (`/gap_detection/move_to_section`)
2. **Topic**: 전체 공정 완료 신호 (`/gap_detection/process_complete`)

#### 통신 플로우 다이어그램
```
TR200 모바일 로봇          두산 로봇
┌─────────────┐          ┌─────────────┐
│             │          │             │
│ Action:     │ ────────►│ Action:     │
│ move_to_    │          │ perform_    │
│ section     │          │ measurement │
│             │          │             │
│ Topic:      │ ────────►│ Topic:      │
│ section_    │          │ measurement_│
│ arrival     │          │ complete    │
│             │          │             │
│ Topic:      │◄─────────│ Topic:      │
│ robot_      │          │ robot_      │
│ status      │          │ status      │
└─────────────┘          └─────────────┘
```

## ⚠️ 주의사항 및 고려사항

### 환경 설정
- ROS1과 ROS2 환경 변수 충돌 방지를 위한 적절한 환경 소싱 순서
- 각 터미널에서 독립적인 환경 설정 필요
- 기존 설치된 ROS 환경과의 호환성 확인

### 안전성
- 로봇 간 충돌 방지를 위한 안전 거리 확보
- 비상 정지 기능 구현
- 상태 확인 후 동작 실행

### 통신 안정성
- 메시지 손실 방지를 위한 재전송 메커니즘
- 통신 타임아웃 처리
- 상태 동기화 검증

### 성능
- 실시간 제어를 위한 통신 지연 최소화
- 메모리 누수 방지
- CPU 사용률 모니터링

## 📈 성공 지표

- [ ] 두 로봇 간 안정적인 통신 확립
- [ ] 전체 공정 시퀀스 완료 시간 < 10분
- [ ] 측정 정확도 > 95%
- [ ] 시스템 안정성 > 99% (24시간 연속 동작)
- [ ] 에러 복구 시간 < 30초

## 🔄 향후 확장 계획

- 다중 로봇 시스템 지원
- 실시간 데이터 시각화
- 원격 모니터링 시스템
- AI 기반 최적화 알고리즘
- 웹 기반 제어 인터페이스

---

**프로젝트 시작일**: 2024년 12월
**예상 완료일**: 2025년 3월
**총 개발 기간**: 약 12주
