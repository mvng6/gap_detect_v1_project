# 측정 명령 메시지
# 두산 로봇에게 갭 측정을 시작하라는 명령

std_msgs/Header header
int32 section_number          # 측정할 구간 번호
geometry_msgs/Pose target_pose # 측정 대상 위치
string measurement_type       # 측정 타입 (gap, step, etc.)
float64 timeout_seconds       # 측정 타임아웃 (초)
bool emergency_stop          # 비상 정지 플래그
