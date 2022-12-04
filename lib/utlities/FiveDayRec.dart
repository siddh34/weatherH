class Record {
  double maxTemp;
  double minTemp;
  double feelsLike;
  int weatherID;
  DateTime  dt;

  Record(
      {
      required this.maxTemp,
      required this.minTemp,
      required this.feelsLike,
      required this.weatherID,
      required this.dt
      }
    );
}
