import 'package:flutter/material.dart';
import 'package:flutter_task_completion_icon/theme.dart';

import 'widget/task_completion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Task Completion Widget Example'),
          backgroundColor: Colors.orangeAccent,
        ),
        body: Center(
          child: TaskCompletionWidget(
              radius: 100,
              duration: Duration(milliseconds: 500),
              bgColor: TColor.bgColor,
              fgColor: TColor.fgColor,
              fgchild: Icon(Icons.monitor, size: 100, color: TColor.fgColor),
              bgchild: Icon(Icons.monitor, size: 100, color: TColor.bgColor)),
        ),
      ),
    );
  }
}
