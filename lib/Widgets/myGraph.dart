

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utlities/tempData.dart';

class myGraph extends StatelessWidget {
  const myGraph({
    Key? key,
    required this.tempRec,
    required this.gradient,
  }) : super(key: key);

  final List<myTempData> tempRec;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 14,
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
                sideTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 25,
                ),
              ),
              topTitles: AxisTitles(),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 65,
                  interval: 1.7,
                  getTitlesWidget: (yVal, meta) {
                    var y = yVal.toStringAsFixed(2);
                    return Text(
                      '$y°',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    );
                  },
                ),
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
                gradient: LinearGradient(
                  colors: gradient
                      .map((color) => color.withOpacity(0.8))
                      .toList(),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: gradient
                        .map((color) => color.withOpacity(0.1))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        width: 340,
        height: 430,
      ),
    );
  }
}
