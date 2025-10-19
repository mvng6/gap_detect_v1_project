# 로봇 상태 메시지
# 개별 로봇의 상태를 나타내는 메시지

std_msgs/Header header
string robot_id               # 로봇 ID (mobile_robot, doosan_robot)
string robot_type             # 로봇 타입
string current_state          # 현재 상태 (IDLE, MOVING, MEASURING, ERROR)
geometry_msgs/Pose current_pose # 현재 위치
geometry_msgs/Twist current_velocity # 현재 속도
bool is_connected             # 연결 상태
float64 battery_level         # 배터리 레벨 (0.0-1.0)
string error_message          # 에러 메시지
