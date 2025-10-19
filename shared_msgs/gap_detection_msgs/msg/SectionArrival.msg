# 구간 도착 신호 메시지
# 모바일 로봇이 특정 구간에 도착했음을 알리는 메시지

std_msgs/Header header
int32 section_number          # 구간 번호 (1, 2, 3)
geometry_msgs/Pose robot_pose # 로봇의 현재 위치
bool is_stopped              # 완전히 정지했는지 여부
string status_message        # 상태 메시지
