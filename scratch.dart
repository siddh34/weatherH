import 'dart:io';

void main() {
  performTasks();
}

Future<void> performTasks() async {
  task1();
  String res = await task2();
  task3(res);
}

void task1() {
  // Duration threeSeconds = Duration(seconds: 3);
  // sleep(threeSeconds);
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2() async {
  String result = ' ';

  Duration threeSeconds = Duration(seconds: 3);
  await Future.delayed(threeSeconds, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });

  return result;
}

void task3(String res) {
  String result = 'task 3 data';
  print('Task 3 complete $res');
}
