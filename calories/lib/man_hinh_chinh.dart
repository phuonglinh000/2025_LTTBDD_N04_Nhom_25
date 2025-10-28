import 'package:flutter/material.dart';

class man_hinh_chinh extends StatefulWidget {
  const man_hinh_chinh({super.key});

  @override
  State<man_hinh_chinh> createState() => _man_hinh_chinhState();
}

class _man_hinh_chinhState extends State<man_hinh_chinh> {
  final List<Map<String, dynamic>> _meals = [
    {'name': 'Chuối', 'calories': 85},
    {'name': 'Cơm', 'calories': 130},
    {'name': 'Trứng luộc', 'calories': 75},
  ];

  final int _goal = 2000;

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _bmi;

  void _calculateBMI() {
    final heightCm = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (heightCm != null && weight != null && heightCm > 0) {
      final heightM = heightCm / 100; 
      setState(() {
        _bmi = weight / (heightM * heightM);
      });
    }
  }

  String _getBmiCategory(double bmi) {
    if (bmi < 18.5) return 'Gầy';
    if (bmi < 25) return 'Bình thường';
    if (bmi < 30) return 'Thừa cân';
    return 'Béo phì';
  }

  @override
  Widget build(BuildContext context) {
    int totalCalories =
        _meals.fold(0, (sum, item) => sum + (item['calories'] as int));
    double progress = totalCalories / _goal;
    if (progress > 1) progress = 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Counter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.blue[50],
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tính BMI',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: _heightController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Chiều cao (cm)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: _weightController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Cân nặng (kg)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),

                    ElevatedButton(
                      onPressed: _calculateBMI,
                      child: const Text('Tính BMI'),
                    ),

                    if (_bmi != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'BMI của bạn: ${_bmi!.toStringAsFixed(1)} (${_getBmiCategory(_bmi!)})',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const Text(
              'Tiến độ hôm nay:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              minHeight: 20,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
            const SizedBox(height: 10),
            Text('$totalCalories / $_goal kcal',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text(
              'Danh sách món ăn:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _meals.length,
                itemBuilder: (context, index) {
                  final meal = _meals[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.restaurant_menu),
                      title: Text(meal['name']),
                      subtitle: Text('${meal['calories']} kcal'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
