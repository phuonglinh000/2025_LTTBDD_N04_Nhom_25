import 'package:flutter/material.dart';

class ManHinhChinh
    extends StatefulWidget {
  const ManHinhChinh({super.key});

  @override
  State<ManHinhChinh> createState() =>
      _ManHinhChinhState();
}

class _ManHinhChinhState
    extends State<ManHinhChinh> {
  int _selectedIndex = 0;

  String _userName = 'Linh';
  double _height = 160;
  double _weight = 59;
  int _age = 20;
  String _gender = 'Nữ';
  String _activityLevel = 'Nhiều';

  final List<Map<String, dynamic>>
  _meals = [
    {'name': 'Chuối', 'calories': 200},
    {'name': 'Cơm', 'calories': 130},
    {
      'name': 'Trứng luộc',
      'calories': 75,
    },
  ];

  final TextEditingController
  _heightController =
      TextEditingController();
  final TextEditingController
  _weightController =
      TextEditingController();
  final TextEditingController
  _ageController =
      TextEditingController();
  final TextEditingController
  _nameController =
      TextEditingController();

  double? _bmi;
  double? _tdee;

  final Map<String, double>
  _activityFactors = {
    'Ít vận động': 1.2,
    'Vận động nhẹ': 1.375,
    'Trung bình': 1.55,
    'Nhiều': 1.725,
    'Rất nhiều': 1.9,
  };

  String _getTodayText() {
    final now = DateTime.now();
    final weekdays = [
      'Thứ Hai',
      'Thứ Ba',
      'Thứ Tư',
      'Thứ Năm',
      'Thứ Sáu',
      'Thứ Bảy',
      'Chủ Nhật',
    ];
    final weekday =
        weekdays[(now.weekday - 1) % 7];
    return '$weekday, ${now.day}/${now.month}/${now.year}';
  }

  @override
  void initState() {
    super.initState();
    _heightController.text = _height
        .toString();
    _weightController.text = _weight
        .toString();
    _ageController.text = _age
        .toString();
    _nameController.text = _userName;
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _calculateBMIandTDEE() {
    final heightCm = double.tryParse(
      _heightController.text,
    );
    final weight = double.tryParse(
      _weightController.text,
    );
    final age = int.tryParse(
      _ageController.text,
    );

    if (heightCm == null ||
        weight == null ||
        age == null ||
        heightCm <= 0)
      return;

    final heightM = heightCm / 100;
    final bmi =
        weight / (heightM * heightM);

    double bmr;
    if (_gender == 'Nam') {
      bmr =
          88.36 +
          (13.4 * weight) +
          (4.8 * heightCm) -
          (5.7 * age);
    } else {
      bmr =
          447.6 +
          (9.2 * weight) +
          (3.1 * heightCm) -
          (4.3 * age);
    }

    final tdee =
        bmr *
        (_activityFactors[_activityLevel] ??
            1.55);

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildPageContent() {
    if (_selectedIndex == 0) {
      final int totalCalories = _meals
          .fold(
            0,
            (sum, item) =>
                sum +
                (item['calories']
                    as int),
          );
      final double goal =
          _tdee ?? 2000.0;

      double progress = (goal > 0)
          ? (totalCalories / goal)
          : 0.0;
      final displayProgress = progress
          .clamp(0.0, 1.0);

      return Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            _getTodayText(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '👋 Xin chào, $_userName!',
          ),
          const SizedBox(height: 16),

          Card(
            color: Colors.pink[50],
            margin:
                const EdgeInsets.only(
                  bottom: 16,
                ),
            child: Padding(
              padding:
                  const EdgeInsets.all(
                    12.0,
                  ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor:
                        Colors
                            .pinkAccent,
                    child: Icon(
                      Icons.person,
                      color:
                          Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      '$_userName - ${_height.toStringAsFixed(0)}cm / ${_weight.toStringAsFixed(0)}kg',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Card(
            color: Colors.blue[50],
            margin:
                const EdgeInsets.only(
                  bottom: 16,
                ),
            child: Padding(
              padding:
                  const EdgeInsets.all(
                    12.0,
                  ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  const Text(
                    'Tính BMI & TDEE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller:
                        _nameController,
                    decoration:
                        const InputDecoration(
                          labelText:
                              'Họ và tên',
                          border:
                              OutlineInputBorder(),
                        ),
                    onChanged:
                        (
                          value,
                        ) => setState(
                          () =>
                              _userName =
                                  value,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller:
                        _heightController,
                    keyboardType:
                        TextInputType
                            .number,
                    decoration: const InputDecoration(
                      labelText:
                          'Chiều cao (cm)',
                      border:
                          OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller:
                        _weightController,
                    keyboardType:
                        TextInputType
                            .number,
                    decoration: const InputDecoration(
                      labelText:
                          'Cân nặng (kg)',
                      border:
                          OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller:
                        _ageController,
                    keyboardType:
                        TextInputType
                            .number,
                    decoration:
                        const InputDecoration(
                          labelText:
                              'Tuổi',
                          border:
                              OutlineInputBorder(),
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed:
                        _calculateBMIandTDEE,
                    child: const Text(
                      'Tính BMI & TDEE',
                    ),
                  ),
                  if (_bmi != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(
                            top: 8,
                          ),
                      child: Text(
                        'BMI: ${_bmi!.toStringAsFixed(1)} (${_getBmiCategory(_bmi!)})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),
                  if (_tdee != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(
                            top: 4,
                          ),
                      child: Text(
                        'TDEE: ${_tdee!.toStringAsFixed(0)} kcal/ngày',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          const Text(
            'Tiến độ hôm nay:',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          Row(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment
                        .center,
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: CircularProgressIndicator(
                          value:
                              displayProgress,
                          strokeWidth:
                              10,
                          backgroundColor:
                              Colors
                                  .grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            progress <
                                    0.9
                                ? Colors
                                      .green
                                : (progress <
                                          1.0
                                      ? Colors.amber
                                      : Colors.red),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.person,
                        size: 48,
                        color: Colors
                            .black54,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${totalCalories.toStringAsFixed(0)} / ${goal.toStringAsFixed(0)} kcal',
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Card(
                  color:
                      Colors.purple[50],
                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                          12.0,
                        ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        const Text(
                          'Giá trị dinh dưỡng hôm nay:',
                          style: TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        _thanhdinhduong(
                          'Carbs',
                          180,
                          200,
                          Colors.orange,
                        ),
                        _thanhdinhduong(
                          'Protein',
                          70,
                          100,
                          Colors.green,
                        ),
                        _thanhdinhduong(
                          'Fat',
                          50,
                          60,
                          Colors
                              .pinkAccent,
                        ),
                        _thanhdinhduong(
                          'Fiber',
                          20,
                          30,
                          Colors.teal,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          const Text(
            'Danh sách món đã ăn:',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            itemCount: _meals.length,
            itemBuilder: (context, index) {
              final meal =
                  _meals[index];
              return Card(
                child: ListTile(
                  leading: const Icon(
                    Icons
                        .restaurant_menu,
                  ),
                  title: Text(
                    meal['name'],
                  ),
                  subtitle: Text(
                    '${meal['calories']} kcal',
                  ),
                ),
              );
            },
          ),
        ],
      );
    } else if (_selectedIndex == 1) {
      return Column(
        children: [
          const Text(
            'Lịch sử ăn uống',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ..._meals.map(
            (m) => ListTile(
              title: Text(m['name']),
              trailing: Text(
                '${m['calories']} kcal',
              ),
            ),
          ),
        ],
      );
    } else {
      return const Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Ghi chú',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Bạn có thể thêm ghi chú hoặc lời nhắc ở đây.',
          ),
        ],
      );
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calorie Counter',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: SingleChildScrollView(
          child: _buildPageContent(),
        ),
      ),
      bottomNavigationBar:
          BottomNavigationBar(
            currentIndex:
                _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor:
                Colors.green,
            unselectedItemColor:
                Colors.grey,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                ),
                label: 'Lịch sử',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.note),
                label: 'Ghi chú',
              ),
            ],
          ),
    );
  }
}

  Widget _thanhdinhduong(
    String name,
    double value,
    double goal,
    Color color,
  ) {
    double progress = (value / goal).clamp(
      0.0,
      1.0,
    );

    String? imagePath;
    IconData icon = Icons.circle;

    switch (name.toLowerCase()) {
      case 'carbs':
      case 'tinh bột':
        imagePath = 'imgs/carbs.png';
        break;
      case 'protein':
      case 'đạm':
        imagePath = 'imgs/protein.png';
        break;
      case 'fat':
      case 'chất béo':
        imagePath = 'imgs/fat.png';
        break;
      case 'fiber':
      case 'chất xơ':
        imagePath = 'imgs/fiber.png';
        break;
      default:
        imagePath = 'assets/icons/default.png';
    }

   // Image.asset(imagePath, width: 50, height: 50);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  imagePath != null
                      ? Image.asset(
                          imagePath,
                          width: 18,
                          height: 18,
                          
                        )
                      : Icon(
                          icon,
                          size: 18,
                          color: color,
                        ),
                  const SizedBox(width: 6),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Text(
                '${value.toStringAsFixed(0)}/${goal.toStringAsFixed(0)}g',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress,
            color: color,
            backgroundColor: Colors.grey[300],
            minHeight: 8,
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ],
      ),
    );
  }
