// ignore_for_file: public_member_api_docs, sort_constructors_first
class ScheduleModel {
  final String requestId;
  final List<String> wasteTypes;
  final String status;
  final String date;
  final String points;
  ScheduleModel({
    required this.requestId,
    required this.wasteTypes,
    required this.status,
    required this.date,
    required this.points,
  });
}
