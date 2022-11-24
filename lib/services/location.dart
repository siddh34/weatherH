import 'package:geolocator/geolocator.dart';

class location {
  late double latitude;
  late double longitude;

  void getPermission() async {
    await Geolocator.requestPermission();
    await Geolocator.checkPermission();
  }

  Future<void> getCurrentlocation() async {
    try {
      getPermission();
      // Future<Position> position = (await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.low)) as Future<Position>;
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (exceptt) {
      print(exceptt);
    }
  }
}
