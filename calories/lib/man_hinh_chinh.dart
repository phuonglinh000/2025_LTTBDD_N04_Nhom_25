import 'package:flutter/material.dart';

class man_hinh_chinh extends StatefulWidget {
  const man_hinh_chinh({super.key});

  @override
  State<man_hinh_chinh> createState() => _man_hinh_chinhState();
}

class _man_hinh_chinhState extends State<man_hinh_chinh> {
  
  String _userName = 'Linh';
  double _height = 160; 
  double _weight = 59; 
  int _age = 20;
  String _gender = 'Nữ';
  String _activityLevel = 'Nhiều';

  
  final List<Map<String, dynamic>> _meals = [
    {'name': 'Chuối', 'calories': 85},
    {'name': 'Cơm', 'calories': 130},
    {'name': 'Trứng luộc', 'calories': 75},
  ];

  
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  double? _bmi;
  double? _tdee;

  final Map<String, double> _activityFactors = {
    'Ít vận động': 1.2,
    'Vận động nhẹ': 1.375,
    'Trung bình': 1.55,
    'Nhiều': 1.725,
    'Rất nhiều': 1.9,
  };

  @override
  void initState() {
    super.initState();
    _heightController.text = _height.toString();
    _weightController.text = _weight.toString();
    _ageController.text = _age.toString();
    
  }

  
  void _calculateBMIandTDEE() {
    final heightCm = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);
    final age = int.tryParse(_ageController.text);

    if (heightCm == null || weight == null || age == null || heightCm <= 0) return;

    final heightM = heightCm / 100;
    final bmi = weight / (heightM * heightM);

    double bmr;
    if (_gender == 'Nam') {
      bmr = 88.36 + (13.4 * weight) + (4.8 * heightCm) - (5.7 * age);
    } else {
      bmr = 447.6 + (9.2 * weight) + (3.1 * heightCm) - (4.3 * age);
    }

    final tdee = bmr * _activityFactors[_activityLevel]!;

    setState(() {
      _bmi = bmi;
      _tdee = tdee;
      _height = heightCm;
      _weight = weight;
      _age = age;
    });
  }

  String _getBmiCategory(double bmi) {
    if (bmi < 18.5) return 'Gầy';
    if (bmi < 25) return 'Bình thường';
    if (bmi < 30) return 'Thừa cân';
    return 'Béo phì';
  }

  @override
  Widget build(BuildContext context) {
    final int totalCalories =
        _meals.fold(0, (sum, item) => sum + (item['calories'] as int));

    final double goal = _tdee ?? 2000.0;

    
    double progress = (goal > 0) ? (totalCalories / goal) : 0.0;
    if (progress.isInfinite || progress.isNaN) progress = 0.0;
    if (progress < 0) progress = 0.0;
    if (progress > 1) progress = 1.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Counter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            
            Card(
              color: Colors.pink[50],
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.pinkAccent,
                      child: Icon(Icons.person, color: Colors.white, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        '$_userName - ${_height.toStringAsFixed(0)}cm / ${_weight.toStringAsFixed(0)}kg',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            
            Card(
              color: Colors.blue[50],
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tính BMI & TDEE',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(children: [
                        const Text('Giới tính:'),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: _gender,
                          items: const [
                            DropdownMenuItem(value: 'Nam', child: Text('Nam')),
                            DropdownMenuItem(value: 'Nữ', child: Text('Nữ')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ]),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Chiều cao (cm)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Cân nặng (kg)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Tuổi',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(children: [
                        const Text('Vận động:'),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: _activityLevel,
                          items: _activityFactors.keys
                              .map((level) =>
                                  DropdownMenuItem(value: level, child: Text(level)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _activityLevel = value!;
                            });
                          },
                        ),
                      ]),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _calculateBMIandTDEE,
                        child: const Text('Tính BMI & TDEE'),
                      ),
                      if (_bmi != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'BMI: ${_bmi!.toStringAsFixed(1)} (${_getBmiCategory(_bmi!)})',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      if (_tdee != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'TDEE: ${_tdee!.toStringAsFixed(0)} kcal/ngày',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ]),
              ),
            ),

            
            const Text('Tiến độ hôm nay:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 10,
                          backgroundColor: Colors.grey[300],
                          color: progress < 0.7 ? Colors.green : Colors.orange,
                        ),
                      ),
                      
                      const Icon(Icons.person, size: 48, color: Colors.black54),
                      
                      
                      
                      
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('${totalCalories.toStringAsFixed(0)} / ${goal.toStringAsFixed(0)} kcal',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text('Danh sách món đã ăn:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
          ]),
        ),
      ),
    );
  }
}
