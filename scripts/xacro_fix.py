#!/usr/bin/env python3

# xacro 대안 실행 스크립트
# ROS2 xacro 실행 파일 문제를 우회하여 직접 실행

import sys
import os

# ROS2 환경 설정
os.environ['ROS_DISTRO'] = 'humble'

# xacro 모듈 직접 실행
try:
    import xacro
    xacro.main()
except Exception as e:
    print(f"Error: {e}", file=sys.stderr)
    sys.exit(1)
