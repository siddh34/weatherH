import 'package:flutter/material.dart';

class myDisplayBox extends StatelessWidget {
  const myDisplayBox({
    Key? key,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.visiblity,
  }) : super(key: key);

  final humidity;
  final pressure;
  final windSpeed;
  final visiblity;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
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
                    Text("Humidity: $humidity%"),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.electric_meter,
                    ),
                    Text("Pressure: $pressure hPa"),
                  ],
                ),
                SizedBox(
                  width: 1,
                ),
                Column(
                  children: [
                    Icon(
                      Icons.wind_power,
                    ),
                    Text("Wind Speed: $windSpeed m/s"),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.panorama_fish_eye_sharp,
                    ),
                    Text("Visibility: $visiblity m"),
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
    );
  }
}

