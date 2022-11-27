import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:clima/utlities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/cityScreen.dart';

class LocationScreen extends StatefulWidget {
  @override
  LocationScreen(this.locationWeather);

  final locationWeather;

  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temp;
  var condition;
  var cityName;
  var weatherIcon;
  var msgDisplay;
  var feelsLike;
  var pressure;
  var humidity;
  var windSpeed;
  var visiblity;
  late String wallpaper = 'images/location_background.jpg';
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();

    // print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        weatherIcon = 'Error';
        cityName = '';
        msgDisplay = 'unable to get weather';
        return;
      }

      var temps = weatherData['main']['temp'];
      temp = temps.toInt();
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      humidity = weatherData['main']['humidity'];
      feelsLike = weatherData['main']['feels_like'];
      pressure = weatherData['main']['pressure'];
      windSpeed = weatherData['wind']['speed'];
      visiblity = weatherData['visibility'];
      weatherIcon = weather.getWeatherIcon(condition);
      msgDisplay = weather.getMessage(temp);
      wallpaper = weather.getWallpaper();
      print(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$wallpaper'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      WeatherModel weatherModel = WeatherModel();
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typeName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typeName != null) {
                        var weatherData =
                            await weather.getCityLocation(typeName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 65.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon️',
                      style: kConditionTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.keyboard_double_arrow_right,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0, left: 10.0),
                        child: Text(
                          '$msgDisplay in $cityName!',
                          textAlign: TextAlign.center,
                          style: kMessageTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              UnconstrainedBox(
                child: Container(
                  child: Material(
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.air_rounded,
                              ),
                              Text("Humidity : $humidity"),
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.electric_meter,
                              ),
                              Text("Pressure : $pressure"),
                            ],
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.wind_power,
                              ),
                              Text("Wind Speed : $windSpeed"),
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.panorama_fish_eye_sharp,
                              ),
                              Text("Visibility : $visiblity"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    color: Colors.white12,
                  ),
                  width: 350,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(35, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
