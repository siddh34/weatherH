import 'dart:ui';

import 'package:clima/utlities/FiveDayRec.dart';
import 'package:clima/utlities/tempData.dart';
import 'package:flutter/material.dart';
import 'package:clima/utlities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/cityScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

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
  late String wallpaper = 'images/location_background.jpg';
  WeatherModel weather = WeatherModel();
  List<Record> DisplayRec = [];
  List<myTempData> tempRec = [];
  List<Text> display = [];
  List<String> val = [];

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
                  child: LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 1:
                                  var t =
                                      DateFormat.jm().format(tempRec[0].time);
                                  return Text(
                                    '$t',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  );
                                case 5:
                                  var t =
                                      DateFormat.jm().format(tempRec[1].time);
                                  return Text(
                                    '$t',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  );
                                case 8:
                                  var t =
                                      DateFormat.jm().format(tempRec[1].time);
                                  return Text(
                                    '$t',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  );
                                case 10:
                                  var t =
                                      DateFormat.jm().format(tempRec[2].time);
                                  return Text(
                                    '$t',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  );
                                case 15:
                                  var t =
                                      DateFormat.jm().format(tempRec[3].time);
                                  return Text(
                                    '$t',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  );
                                case 20:
                                  var t =
                                      DateFormat.jm().format(tempRec[4].time);
                                  return Text(
                                    '$t',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  );
                                case 24:
                                  var t =
                                      DateFormat.jm().format(tempRec[5].time);
                                  return Text(
                                    '$t',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  );
                                default:
                                  return Text('');
                              }
                            },
                            // interval: 3,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          axisNameWidget: Text('Temperture'),
                        ),
                        topTitles: AxisTitles(
                          axisNameWidget: Text('Time'),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(1, tempRec[0].temp),
                            FlSpot(4, tempRec[1].temp),
                            FlSpot(8, tempRec[2].temp),
                            FlSpot(12, tempRec[3].temp),
                            FlSpot(16, tempRec[4].temp),
                            FlSpot(20, tempRec[5].temp),
                            FlSpot(24, tempRec[6].temp),
                          ],
                          isCurved: true,
                        ),
                      ],
                    ),
                  ),
                  width: 370,
                  height: 350,
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
                    color: Color.fromARGB(31, 128, 117, 117),
                  ),
                  width: 350,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(47, 167, 150, 150),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              UnconstrainedBox(
                child: Container(
                  child: Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: display,
                    ),
                    color: Color.fromARGB(31, 128, 117, 117),
                  ),
                  width: 350,
                  height: 265,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(35, 167, 150, 150),
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
