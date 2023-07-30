class Waste {
  final String id;
  final String wasteId;
  final String wasteClass;
  final List<String> wasteTypes;
  final String? imagePath;
  final DateTime date;
  final String time;
  final String location;
  final String? status;
  final int points;
  Waste({
    required this.wasteId,
    required this.id,
    required this.wasteClass,
    required this.wasteTypes,
    this.imagePath,
    required this.date,
    required this.time,
    required this.location,
    this.status,
    required this.points,
  });
}
