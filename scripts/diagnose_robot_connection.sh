#!/bin/bash
echo "🔍 두산 로봇 연결 진단 및 해결 스크립트"
echo "=========================================="

# ROS2 환경 설정
source ~/gap_detect_v1_ws/scripts/setup_ros2_clean_final.sh

echo ""
echo "1️⃣ 네트워크 연결 상태 확인"
echo "---------------------------"

# 로봇 IP들 ping 테스트
echo "로봇 IP 192.168.137.100 ping 테스트:"
ping -c 2 192.168.137.100

echo ""
echo "로봇 RT IP 192.168.137.50 ping 테스트:"
ping -c 2 192.168.137.50

echo ""
echo "2️⃣ 포트 연결 테스트"
echo "-------------------"

# 포트 12345 연결 테스트
echo "포트 12345 연결 테스트:"
timeout 5 bash -c "</dev/tcp/192.168.137.100/12345" && echo "✅ 포트 12345 연결 성공" || echo "❌ 포트 12345 연결 실패"

echo ""
echo "3️⃣ 로봇 서비스 상태 확인"
echo "------------------------"

# nmap으로 포트 스캔 (설치되어 있다면)
if command -v nmap &> /dev/null; then
    echo "로봇 포트 스캔 결과:"
    nmap -p 12345 192.168.137.100
else
    echo "nmap이 설치되지 않음. 설치하려면: sudo apt install nmap"
fi

echo ""
echo "4️⃣ ROS2 환경 확인"
echo "------------------"
echo "ROS_DISTRO: $ROS_DISTRO"
echo "ROS_VERSION: $ROS_VERSION"
echo "xacro 위치: $(which xacro)"

echo ""
echo "5️⃣ 두산 로봇 패키지 확인"
echo "----------------------"
ros2 pkg list | grep dsr

echo ""
echo "6️⃣ 해결 방법 제안"
echo "=================="
echo ""
echo "🔧 문제 해결 방법:"
echo ""
echo "1. 로봇 컨트롤러 확인:"
echo "   - 로봇 전원이 켜져 있는지 확인"
echo "   - 로봇 컨트롤러에서 TCP/IP 서비스가 활성화되어 있는지 확인"
echo "   - 로봇 설정에서 포트 12345가 열려있는지 확인"
echo ""
echo "2. 네트워크 설정 확인:"
echo "   - 노트북과 로봇이 같은 네트워크에 있는지 확인"
echo "   - 방화벽이 포트 12345를 차단하지 않는지 확인"
echo ""
echo "3. 로봇 모델 및 설정 확인:"
echo "   - 로봇 모델이 a0912가 맞는지 확인"
echo "   - 로봇 IP 주소가 정확한지 확인"
echo ""
echo "4. 대안 명령어 시도:"
echo "   ros2 launch dsr_bringup2 dsr_bringup2_rviz.launch.py mode:=virtual host:=127.0.0.1 port:=12345 model:=a0912"
echo "   (가상 모드로 먼저 테스트)"
echo ""
echo "5. 로봇 컨트롤러 재시작:"
echo "   - 로봇 컨트롤러를 재시작하고 TCP/IP 서비스를 다시 활성화"
echo ""
