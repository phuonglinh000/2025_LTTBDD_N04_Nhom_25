import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'quan_ly_ngon_ngu.dart';

class ManHinhLichSu extends StatelessWidget {
  final List<Map<String, dynamic>> meals;

  const ManHinhLichSu({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    Lang.currentLang = provider.locale.languageCode;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            Lang.t('meal_history'),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E8B57),
            ),
          ),
          const SizedBox(height: 20),

          // === Biểu đồ lịch sử ăn uống ===
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
                        if (index < 0 || index >= meals.length) {
                          return const SizedBox();
                        }
                        return Text(
                          Lang.t(meals[index]['name']),
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text('${value.toInt()}');
                      },
                    ),
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
                        color: const Color.fromARGB(255, 136, 169, 226),
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
              title: Text(Lang.t(m['name'])),
              trailing: Text(
                '${m['calories']} ${Lang.t('kcal')}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
