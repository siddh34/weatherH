import 'package:geolocator/geolocator.dart';

class location {
  late double latitude;
  late double longitude;

  void getPermission() async {
    LocationPermission permission1 = await Geolocator.requestPermission();
    LocationPermission permission = await Geolocator.checkPermission();
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
