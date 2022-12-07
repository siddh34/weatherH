import 'dart:ui';

import 'package:clima/utlities/FiveDayRec.dart';
import 'package:clima/utlities/tempData.dart';
import 'package:flutter/material.dart';
import 'package:clima/utlities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/cityScreen.dart';

import '../Widgets/day5PredList.dart';
import '../Widgets/displayBox.dart';
import '../Widgets/myGraph.dart';

// ignore: must_be_immutable
class LocationScreen extends StatefulWidget {
  var tempList;

  @override
  LocationScreen(this.locationWeather, this.tempList);

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
  var sunrise;
  var sunset;
  late String wallpaper = 'images/location_background.jpg';
  WeatherModel weather = WeatherModel();
  List<Record> DisplayRec = [];
  List<myTempData> tempRec = [];
  List<Text> display = [];
  List<String> val = [];
  List<Color> gradient = [
    Color.fromARGB(255, 27, 160, 205),
    Color.fromARGB(221, 35, 188, 122)
  ];

  @override
  void initState() {
    super.initState();

    // getting required list
    tempRec = widget.tempList;
    updateUI(widget.locationWeather);
    LoadData();
  }

  // returns a list of record for 5 days
  LoadData() async {
    DisplayRec = await weather.day5TempList() as List<Record>;
    var tpl = await weather.TempList() as List<myTempData>;
    setState(() {
      for (int i = 0; i < DisplayRec.length; i++) {
        tempRec = tpl;
        double maxTemp = DisplayRec[i].maxTemp;
        double minTemp = DisplayRec[i].minTemp;
        double feelsLike = DisplayRec[i].feelsLike;
        var icon = weather.getWeatherIcon(DisplayRec[i].weatherID);
        var day = DisplayRec[i].dt.day.toString();
        var Month = DisplayRec[i].dt.month.toString();
        var year = DisplayRec[i].dt.year.toString();

        var myText = Text(
          '    \n \t $day-$Month-$year -> $icon  feels like: $feelsLike°\n\t\t  minTemp: $minTemp° maxTemp: $maxTemp°',
          textAlign: TextAlign.start,
        );
        display.add(myText);
        // print(display);
      }
    });
  }

  CityLoadData(String city) async {
    DisplayRec = await weather.Cityday5TempList(city) as List<Record>;
    var tpl = await weather.CityTempList(city) as List<myTempData>;
    setState(() {
      for (int i = 0; i < DisplayRec.length; i++) {
        tempRec = tpl;
        double maxTemp = DisplayRec[i].maxTemp;
        double minTemp = DisplayRec[i].minTemp;
        double feelsLike = DisplayRec[i].feelsLike;
        var icon = weather.getWeatherIcon(DisplayRec[i].weatherID);
        var day = DisplayRec[i].dt.day.toString();
        var Month = DisplayRec[i].dt.month.toString();
        var year = DisplayRec[i].dt.year.toString();
        var myText = Text(
          '    \n \t $day-$Month-$year -> $icon  feels like: $feelsLike°\n\t\t minTemp: $minTemp° maxTemp: $maxTemp°',
          textAlign: TextAlign.start,
        );
        display.add(myText);
        // print(display);
      }

      // clearing the previous value
      DisplayRec.clear();

      for (int i = 0; i < 4; i++) {
        display.removeAt(0);
      }

      for (int i = 0; i < 11; i++) {
        tempRec.removeAt(0);
      }
    });
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
      sunrise = weatherData['sys']['sunrise'];
      sunset = weatherData['sys']['sunset'];
      // updateUI
      weatherIcon = weather.getWeatherIcon(condition);
      msgDisplay = weather.getMessage(temp);
      wallpaper = weather.getWallpaper();

      print(DateTime.tryParse(sunset.toString() + 'z')?.toLocal());
      print(DateTime.tryParse(sunrise.toString() + 'z')?.toLocal());

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
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      WeatherModel weatherModel = WeatherModel();
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                      await LoadData();

                      // clearing the previous value
                      DisplayRec.clear();

                      for (int i = 0; i < 4; i++) {
                        display.removeAt(0);
                      }

                      for (int i = 0; i < 11; i++) {
                        tempRec.removeAt(0);
                      }
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
                        await CityLoadData(typeName);
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
              myGraph(tempRec: tempRec, gradient: gradient),
              SizedBox(
                height: 20,
              ),
              myDisplayBox(humidity: humidity, pressure: pressure, windSpeed: windSpeed, visiblity: visiblity),
              SizedBox(
                height: 20,
              ),
              day5PredList(display: display),
            ],
          ),
        ),
      ),
    );
  }
}

