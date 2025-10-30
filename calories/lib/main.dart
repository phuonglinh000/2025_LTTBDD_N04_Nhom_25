import 'package:flutter/material.dart';
import 'man_hinh_chinh.dart';

void main() {
  runApp(const CalorieApp());
}

class CalorieApp
    extends StatelessWidget {
  const CalorieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calorie Counter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ManHinhChinh(),
    );
  }
}
