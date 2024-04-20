class StationData {
  String id;
  String title;
  String imageUrl;
  String details;
  String type;
  String country;
  int status;
  String date;
  double lat;
  double lng;

  StationData(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.details,
      required this.type,
      required this.country,
      required this.status,
      required this.date,
      required this.lat,
      required this.lng});
}
