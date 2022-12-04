import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utlities/FiveDayRec.dart';
import 'package:clima/utlities/tempData.dart';

class WeatherModel {
  var myLatitude;
  var myLongitude;
  late String wallpaper;
  List<myTempData> temp = [];

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
      Record rec = Record(
          maxTemp: double.parse(data['main']['temp_max'].toString()),
          minTemp: double.parse(data['main']['temp_min'].toString()),
          feelsLike: double.parse(data['main']['feels_like'].toString()),
          weatherID: int.parse(data['weather'][0]['id'].toString()),
          dt: DateTime.parse(data['dt_txt'].toString()));
      displayRecords.add(rec);
    }

    // sorting the records
    var currentDT = displayRecords[0].dt;

    List<Record> newDisplayRecords = [];

    // fetching five records
    for (int i = 0; i < displayRecords.length; i++) {
      if (currentDT.difference(displayRecords[i].dt).inHours == -24 ||
          currentDT.difference(displayRecords[i].dt).inHours == -48 ||
          currentDT.difference(displayRecords[i].dt).inHours == -72 ||
          currentDT.difference(displayRecords[i].dt).inHours == -96) {
        newDisplayRecords.add(displayRecords[i]);
      }
    }

    return newDisplayRecords;
  }

  Future<List<dynamic>> Cityday5TempList(String city) async {
    // getting location
    location getLoc = location();
    await getLoc.getCurrentlocation();
    myLatitude = getLoc.latitude;
    myLongitude = getLoc.longitude;
    
    var myday5URL =
        "http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=67c83c2980a8b84b1e620175281173fd&units=metric";

    List<Record> displayRecords = [];

    networkBuilder NB = networkBuilder(myday5URL);

    dynamic jsonData = await NB.getMyData();

    for (var data in jsonData['list'] as List) {
      Record rec = Record(
          maxTemp: double.parse(data['main']['temp_max'].toString()),
          minTemp: double.parse(data['main']['temp_min'].toString()),
          feelsLike: double.parse(data['main']['feels_like'].toString()),
          weatherID: int.parse(data['weather'][0]['id'].toString()),
          dt: DateTime.parse(data['dt_txt'].toString()));
      displayRecords.add(rec);
    }

    // sorting the records
    var currentDT = displayRecords[0].dt;

    List<Record> newDisplayRecords = [];

    // fetching five records
    for (int i = 0; i < displayRecords.length; i++) {
      if (currentDT.difference(displayRecords[i].dt).inHours == -24 ||
          currentDT.difference(displayRecords[i].dt).inHours == -48 ||
          currentDT.difference(displayRecords[i].dt).inHours == -72 ||
          currentDT.difference(displayRecords[i].dt).inHours == -96) {
        newDisplayRecords.add(displayRecords[i]);
      }
    }

    return newDisplayRecords;
  }

  Future<List<dynamic>> TempList() async {
    // getting location
    location getLoc = location();
    await getLoc.getCurrentlocation();
    myLatitude = getLoc.latitude;
    myLongitude = getLoc.longitude;

    var myday5URL =
        "http://api.openweathermap.org/data/2.5/forecast?lat=$myLatitude&lon=$myLongitude&appid=67c83c2980a8b84b1e620175281173fd&units=metric";

    networkBuilder NB = networkBuilder(myday5URL);

    dynamic jsonData = await NB.getMyData();

    int i = 0;
    for (var data in jsonData['list'] as List) {
      // preparing temp list for graph
      if (i >= 11) {
        break;
      }
      temp.add(myTempData(
          temp: data['main']['temp'],
          time: DateTime.parse(data['dt_txt'].toString())
          )
        );
      i++;
    }

    return temp;
  }

  Future<List<dynamic>> CityTempList(String city) async {
    // getting location
    location getLoc = location();
    await getLoc.getCurrentlocation();
    myLatitude = getLoc.latitude;
    myLongitude = getLoc.longitude;

    var myday5URL =
        "http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=67c83c2980a8b84b1e620175281173fd&units=metric";

    networkBuilder NB = networkBuilder(myday5URL);

    dynamic jsonData = await NB.getMyData();

    int i = 0;
    for (var data in jsonData['list'] as List) {
      // preparing temp list for graph
      if (i >= 11) {
        break;
      }
      temp.add(myTempData(
          temp: data['main']['temp'],
          time: DateTime.parse(data['dt_txt'].toString())
          )
        );
      i++;
    }

    return temp;
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
