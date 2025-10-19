cmake_minimum_required(VERSION 3.0.2)
project(gap_detection_msgs)

find_package(catkin REQUIRED COMPONENTS
  message_generation
  std_msgs
  geometry_msgs
)

add_message_files(
  FILES
  SectionArrival.msg
  MeasurementCommand.msg
  MeasurementResult.msg
  ProcessComplete.msg
)

add_service_files(
  FILES
  StartMeasurement.srv
  StopMeasurement.srv
)

generate_messages(
  DEPENDENCIES
  std_msgs
  geometry_msgs
)

catkin_package(
  CATKIN_DEPENDS message_runtime std_msgs geometry_msgs
)
