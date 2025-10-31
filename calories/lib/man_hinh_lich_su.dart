import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ManHinhLichSu extends StatelessWidget {
  final List<Map<String, dynamic>> meals;

  const ManHinhLichSu({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          const SizedBox(height: 20),

          
          SizedBox(
            height: 250,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= meals.length) return const SizedBox();
                        return Text(
                          meals[index]['name'],
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: meals.asMap().entries.map((entry) {
                  final index = entry.key;
                  final meal = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: meal['calories'].toDouble(),
                        width: 20,
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.teal,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 24),

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