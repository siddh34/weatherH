import 'package:flutter/material.dart';

class day5PredList extends StatelessWidget {
  const day5PredList({
    Key? key,
    required this.display,
  }) : super(key: key);

  final List<Text> display;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
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
        height: 280,
        decoration: BoxDecoration(
          color: Color.fromARGB(35, 167, 150, 150),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}

