import 'package:flutter/material.dart';

class ManHinhLichSu extends StatelessWidget {
  final List<Map<String, dynamic>> meals;

  const ManHinhLichSu({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Lịch sử ăn uống',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...meals.map(
            (m) => ListTile(
              title: Text(m['name']),
              trailing: Text('${m['calories']} kcal'),
            ),
          ),
        ],
      ),
    );
  }
}