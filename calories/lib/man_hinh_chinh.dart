import 'package:calories/man_hinh_lich_su.dart';
import 'package:flutter/material.dart';
import 'man_hinh_ghi_chu.dart';
import 'man_hinh_tap_luyen.dart';

class DateSelector
    extends StatefulWidget {
  final Function(DateTime)
  onDateSelected;
  const DateSelector({
    Key? key,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<DateSelector> createState() =>
      _DateSelectorState();
}

class _DateSelectorState
    extends State<DateSelector> {
  DateTime selectedDate =
      DateTime.now();
  late ScrollController
  _scrollController;

final int totalDays = DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;

  @override
  void initState() {
    super.initState();

    _scrollController =
        ScrollController();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
          final middle =
              (totalDays / 2) * 60.0;
          if (_scrollController
              .hasClients) {
            _scrollController.jumpTo(
              middle,
            );
          }
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _getShortWeekday(int wd) {
    switch (wd) {
      case 1:
        return 'T2';
      case 2:
        return 'T3';
      case 3:
        return 'T4';
      case 4:
        return 'T5';
      case 5:
        return 'T6';
      case 6:
        return 'T7';
      case 7:
        return 'CN';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              "🐝 ",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Chọn ngày",
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 90,
          child: ListView.builder(
            controller:
                _scrollController,
            scrollDirection:
                Axis.horizontal,
            physics:
                const BouncingScrollPhysics(),
            itemCount: totalDays,
            itemBuilder: (context, index) {
              final day = index + 1;
              final date = DateTime(DateTime.now().year, DateTime.now().month, day);


              final isSelected =
                  date.year ==
                      selectedDate
                          .year &&
                  date.month ==
                      selectedDate
                          .month &&
                  date.day ==
                      selectedDate.day;

              return GestureDetector(
                onTap: () {
                  setState(
                    () => selectedDate =
                        date,
                  );
                  widget.onDateSelected(
                    date,
                  );
                },
                child: AnimatedContainer(
                  duration:
                      const Duration(
                        milliseconds:
                            180,
                      ),
                  margin:
                      const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 6,
                      ),
                  padding:
                      const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.green
                        : Colors
                              .grey[200],
                    borderRadius:
                        BorderRadius.circular(
                          12,
                        ),
                  ),
                child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      _getShortWeekday(date.weekday),
      style: TextStyle(
        color: isSelected ? Colors.white : Colors.black54,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    const SizedBox(height: 4),
    Text(
      '$day',
      style: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  ],
),



                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

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

  DateTime _selectedDate =
      DateTime.now();

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

  String _getFormattedDate(
    DateTime date,
  ) {
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
        weekdays[(date.weekday - 1) %
            7];
    return '$weekday, ${date.day}/${date.month}/${date.year}';
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
          DateSelector(
            onDateSelected:
                (selectedDate) {
                  setState(() {
                    _selectedDate =
                        selectedDate;
                  });
                },
          ),
          const SizedBox(height: 8),
          Text(
            _getFormattedDate(
              _selectedDate,
            ),
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
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            children: [
              const Text(
                'Danh sách món đã ăn:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  _themmonan();
                },
              ),
            ],
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
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        _meals.removeAt(
                          index,
                        );
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      );
    } else if (_selectedIndex == 1) {
      return ManHinhLichSu(
        meals: _meals,
      );
    } else if (_selectedIndex == 2) {
      return const ManHinhTapLuyen();
    } else if (_selectedIndex == 3) {
      return const SizedBox.shrink();
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
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.note_alt_outlined,
              color: Colors.white,
            ),
            tooltip: 'Ghi chú',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ManHinhGhiChu(),
                ),
              );
            },
          ),
        ],
      ),
      body: _selectedIndex == 2
          ? _buildPageContent()
          : Padding(
              padding:
                  const EdgeInsets.all(
                    16.0,
                  ),
              child: ListView(
                children: [
                  _buildPageContent(),
                ],
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
                icon: Icon(
                  Icons.fitness_center,
                ),
                label: 'Luyện tập',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: 'Thông tin nhóm',
              ),
            ],
          ),
    );
  }

  void _themmonan() {
  String newMealName = '';
  String newCalories = '';
  final List<Map<String, dynamic>> availableMeals = [
    {'name': 'Cơm', 'calories': 130},
    {'name': 'Phở bò', 'calories': 400},
    {'name': 'Trứng luộc', 'calories': 75},
    {'name': 'Chuối', 'calories': 200},
    {'name': 'Sữa tươi', 'calories': 150},
    {'name': 'Bánh mì', 'calories': 250},
    {'name': 'Cá hồi', 'calories': 300},
    {'name': 'Cà chua', 'calories': 300},
    {'name': 'Chè đỗ đen', 'calories': 420},
    {'name': 'Cá ba sa', 'calories': 300},
    {'name': 'Thịt lợn rang', 'calories': 150},
    {'name': 'Cà chua', 'calories': 300},
    {'name': 'Dưa chuột', 'calories': 15},
    {'name': 'Trà sữa', 'calories': 450},
    {'name': 'Cà phê đen', 'calories': 50},
    {'name': 'Thịt bò xào', 'calories': 250},
    {'name': 'Thịt lợn thăn', 'calories': 300},
    {'name': 'Thịt nạc vai', 'calories': 300},
    {'name': 'Lạc rang', 'calories': 300},
    {'name': 'Ổi', 'calories': 300},
    {'name': 'Cá chim', 'calories': 300},
    {'name': 'Cá trê', 'calories': 300},
    {'name': 'Cua', 'calories': 300},
    {'name': 'Tôm', 'calories': 300},
    {'name': 'Nước cam', 'calories': 300},
    {'name': 'Bánh mì', 'calories': 300},

  ];

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text('Thêm món mới'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Món ăn :'),
                  const SizedBox(height: 6),
                  Autocomplete<Map<String, dynamic>>(
                    displayStringForOption: (meal) =>
                        '${meal['name']} (${meal['calories']} kcal)',
                    optionsBuilder:
                        (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<Map<String, dynamic>>.empty();
                      }
                      return availableMeals.where((meal) => meal['name']
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()));
                    },
                    onSelected: (meal) {
                      setStateDialog(() {
                        newMealName = meal['name'];
                        newCalories = meal['calories'].toString();
                      });
                    },
                    fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          labelText: 'Tìm kiếm món ăn',
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text('Thêm món mới:'),
                  const SizedBox(height: 6),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Tên món',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => newMealName = value,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Calo (kcal)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => newCalories = value,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (newMealName.isNotEmpty && newCalories.isNotEmpty) {
                    setState(() {
                      _meals.add({
                        'name': newMealName,
                        'calories': int.tryParse(newCalories) ?? 0,
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Thêm'),
              ),
            ],
          );
        },
      );
    },
  );
}


  Widget _thanhdinhduong(
    String name,
    double value,
    double goal,
    Color color,
  ) {
    double progress = (value / goal)
        .clamp(0.0, 1.0);

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
        imagePath =
            'assets/icons/default.png';
    }

    return Padding(
      padding:
          const EdgeInsets.symmetric(
            vertical: 4.0,
          ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
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
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    name,
                    style:
                        const TextStyle(
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
          ClipRRect(
            borderRadius:
                BorderRadius.circular(
                  10,
                ),
            child:
                LinearProgressIndicator(
                  value: progress,
                  color: color,
                  backgroundColor:
                      Colors.grey[300],
                  minHeight: 8,
                ),
          ),
        ],
      ),
    );
  }
}
