import 'package:flutter/material.dart';

class man_hinh_chinh extends StatefulWidget {
  const man_hinh_chinh({super.key});

  @override
  State<man_hinh_chinh> createState() =>
      _man_hinh_chinhState();
}

class _man_hinh_chinhState extends State<man_hinh_chinh> {
  final List<Map<String,dynamic>> _meals = [
    {'name' : 'chuối' , 'calories' : 85},
    {'name' : 'cơm' , 'calories' : 130},
    {'name' : 'trứng luộc' , 'calories' : 75},

  ]


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
