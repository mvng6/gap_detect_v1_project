# 시스템 상태 메시지
# 전체 시스템의 상태를 나타내는 메시지

std_msgs/Header header
string system_id              # 시스템 ID
int32 current_section         # 현재 구간
string mobile_robot_state     # 모바일 로봇 상태
string doosan_robot_state     # 두산 로봇 상태
bool is_measuring             # 측정 중 여부
bool emergency_stop           # 비상 정지 상태
float64 system_uptime         # 시스템 가동 시간
string[] active_nodes         # 활성 노드 목록
