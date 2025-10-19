# 로봇 간 협업 명령 메시지
# 로봇 간 협업을 위한 명령 메시지

std_msgs/Header header
string command_type           # 명령 타입 (MOVE_TO_SECTION, START_MEASUREMENT, RETURN_HOME)
string target_robot           # 대상 로봇 (mobile_robot, doosan_robot)
int32 target_section          # 목표 구간
geometry_msgs/Pose target_pose # 목표 위치
string parameters             # 추가 파라미터 (JSON 형태)
bool wait_for_completion      # 완료 대기 여부
float64 timeout_seconds       # 타임아웃 (초)
