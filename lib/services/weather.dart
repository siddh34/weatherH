import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  var myLatitude;
  var myLongitude;

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
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
