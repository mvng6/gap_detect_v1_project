# 프로세스 완료 신호 메시지
# 전체 측정 프로세스가 완료되었음을 알리는 메시지

std_msgs/Header header
bool process_complete         # 프로세스 완료 여부
int32 total_sections         # 전체 구간 수
int32 completed_sections     # 완료된 구간 수
float64[] all_measurements   # 모든 구간의 측정 결과
time completion_time         # 완료 시간
string final_status          # 최종 상태 메시지
