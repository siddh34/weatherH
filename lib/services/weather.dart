import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utlities/FiveDayRec.dart';

class WeatherModel {
  var myLatitude;
  var myLongitude;
  late String wallpaper;
  List<dynamic> temp = [];

  Future<dynamic> getCityLocation(String cityName) async {
    var url = 'https://api.openweathermap.org/data/2'
        '.5/weather?q=$cityName&appid=67c83c2980a8b84b1e620175281173fd&units=metric';

    networkBuilder NB = networkBuilder(url);
    var weatherData = await NB.getMyData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    location getLoc = location();
    await getLoc.getCurrentlocation();
    myLatitude = getLoc.latitude;
    myLongitude = getLoc.longitude;

    String myUrl = 'https://api.openweathermap.org/data/2'
        '.5/weather?lat=$myLatitude&lon=$myLongitude&appid'
        '=67c83c2980a8b84b1e620175281173fd&units=metric';

    networkBuilder NB = networkBuilder(myUrl);
    var weatherData = await NB.getMyData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      wallpaper = "lightning.jpg";
      return '🌩';
    } else if (condition < 400) {
      wallpaper = "location_background.jpg";
      return '🌧';
    } else if (condition < 600) {
      wallpaper = "location_background.jpg";
      return '☔️';
    } else if (condition < 700) {
      wallpaper = "Cold.jpg";
      return '☃️';
    } else if (condition < 800) {
      wallpaper = "Relax.jpg";
      return '🌫';
    } else if (condition == 800) {
      wallpaper = "warm.jpg";
      return '☀️';
    } else if (condition <= 804) {
      wallpaper = "cloudy.jpg";
      return '☁️';
    } else {
      wallpaper = "location_background.jpg";
      return '🤷‍';
    }
  }

  Future<List<dynamic>> day5TempList() async {
    // getting location
    location getLoc = location();
    await getLoc.getCurrentlocation();
    myLatitude = getLoc.latitude;
    myLongitude = getLoc.longitude;

    var myday5URL =
        "http://api.openweathermap.org/data/2.5/forecast?lat=$myLatitude&lon=$myLongitude&appid=67c83c2980a8b84b1e620175281173fd&units=metric";

    List<Record> displayRecords = [];

    networkBuilder NB = networkBuilder(myday5URL);

    dynamic jsonData = await NB.getMyData();

    for (var data in jsonData['list'] as List) {
      displayRecords.add(Record(
          maxTemp: data['main']['temp_max'],
          minTemp: data['main']['temp_min'],
          feelsLike: data['main']['feels_like'],
          weatherID: data['weather'][0]['id']));
      temp.add(data['main']['temp']);
    }

    print(displayRecords);

    return displayRecords;
  }

  String getMessage(int temp) {
    if (temp >= 25) {
      return 'Its warm 🥵';
    } else if (temp >= 20) {
      return 'Relaxing time 😁';
    } else if (temp <= 10) {
      wallpaper = "Cold.jpg";
      return 'Its cold 🤧';
    } else {
      return '😑 weather';
    }
  }

  String getWallpaper() {
    return wallpaper.toString();
  }
}
