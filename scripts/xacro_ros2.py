#!/usr/bin/env python3
"""
ROS2 xacro 실행 스크립트
ROS1과 ROS2 환경 충돌을 해결하기 위한 래퍼 스크립트
"""

import sys
import os

# ROS1 경로를 PYTHONPATH에서 제거
if 'PYTHONPATH' in os.environ:
    pythonpath = os.environ['PYTHONPATH']
    # ROS1 경로 제거
    paths = pythonpath.split(':')
    filtered_paths = [p for p in paths if 'noetic' not in p and 'install_isolated' not in p]
    os.environ['PYTHONPATH'] = ':'.join(filtered_paths)

# ROS1 sys.path에서 제거
ros1_paths = [p for p in sys.path if 'noetic' in p or 'install_isolated' in p]
for path in ros1_paths:
    if path in sys.path:
        sys.path.remove(path)

# ROS2 xacro 모듈 사용
try:
    # ROS2 xacro 모듈 직접 import
    import xacro
    xacro.main()
except ImportError as e:
    print(f"Error: ROS2 xacro 모듈을 찾을 수 없습니다: {e}")
    print("다음 명령어로 설치하세요: pip3 install --user xacro==2.1.1")
    sys.exit(1)
except Exception as e:
    print(f"Error: xacro 실행 중 오류 발생: {e}")
    sys.exit(1)
