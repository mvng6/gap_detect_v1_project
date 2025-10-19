# 측정 결과 메시지
# 두산 로봇이 갭 측정을 완료했을 때 반환하는 결과

std_msgs/Header header
int32 section_number          # 측정한 구간 번호
bool measurement_success      # 측정 성공 여부
float64[] measurement_data   # 측정 데이터 (갭 크기, 단차 등)
geometry_msgs/Pose measurement_pose # 측정 위치
builtin_interfaces/Time measurement_time # 측정 시간
string error_message         # 에러 메시지 (실패 시)
bool is_home_position        # 홈 포지션 복귀 완료 여부
