import 'package:calories/man_hinh_lich_su.dart';
import 'package:flutter/material.dart';
import 'man_hinh_ghi_chu.dart';
import 'man_hinh_tap_luyen.dart';
import 'chon_ngay.dart';
import 'package:provider/provider.dart';
import 'quan_ly_ngon_ngu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
    {
      'name': 'Chuối',
      'calories': 200,
      'carbs': 50,
      'protein': 1.0,
      'fat': 1.0,
      'fiber': 3.0,
    },
    {
      'name': 'Cơm',
      'calories': 130,
      'carbs': 28,
      'protein': 2.7,
      'fat': 0.3,
      'fiber': 0.4,
    },
    {
      'name': 'Trứng luộc',
      'calories': 75,
      'carbs': 0.5,
      'protein': 6.0,
      'fat': 5.3,
      'fiber': 0.0,
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
      final double totalCarbs = _meals
          .fold(
            0.0,
            (sum, item) =>
                sum +
                ((item['carbs'] ?? 0)
                    as num),
          )
          .toDouble();
      final double totalProtein = _meals
          .fold(
            0.0,
            (sum, item) =>
                sum +
                ((item['protein'] ?? 0)
                    as num),
          )
          .toDouble();
      final double totalFat = _meals
          .fold(
            0.0,
            (sum, item) =>
                sum +
                ((item['fat'] ?? 0)
                    as num),
          )
          .toDouble();
      final double totalFiber = _meals
          .fold(
            0.0,
            (sum, item) =>
                sum +
                ((item['fiber'] ?? 0)
                    as num),
          )
          .toDouble();

      final double goalCarbs = 250;
      final double goalProtein = 100;
      final double goalFat = 70;
      final double goalFiber = 30;

      return Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          chon_ngay(
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
            "${Lang.t('hello')}, $_userName!",
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
                  Text(
                    Lang.t(
                      'calculate_bmi_tdee',
                    ),
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
                    decoration: InputDecoration(
                      labelText: Lang.t(
                        'full_name',
                      ),
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
                    decoration: InputDecoration(
                      labelText: Lang.t(
                        'height_cm',
                      ),
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
                    decoration: InputDecoration(
                      labelText: Lang.t(
                        'weight_kg',
                      ),
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
                        InputDecoration(
                          labelText:
                              Lang.t(
                                'age',
                              ),
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
                    child: Text(
                      Lang.t(
                        'calculate_bmi_tdee',
                      ),
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
                        '${Lang.t('tdee_label')} ${_tdee!.toStringAsFixed(0)} ${Lang.t('calories_per_day')}',
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

          Text(
            Lang.t('today_progress'),
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
                                    1.0
                                ? Colors
                                      .amber
                                : (progress ==
                                          1.0
                                      ? Colors.green
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
                        Text(
                          Lang.t(
                            'today_nutrition',
                          ),
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
                          Lang.t(
                            'carbs',
                          ),
                          totalCarbs,
                          goalCarbs,
                          Colors.orange,
                        ),

                        _thanhdinhduong(
                          Lang.t(
                            'protein',
                          ),
                          totalProtein,
                          goalProtein,
                          Colors.green,
                        ),

                        _thanhdinhduong(
                          Lang.t('fat'),
                          totalFat,
                          goalFat,
                          Colors
                              .pinkAccent,
                        ),

                        _thanhdinhduong(
                          Lang.t(
                            'fiber',
                          ),
                          totalFiber,
                          goalFiber,
                          Colors.teal,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            children: [
              Text(
                Lang.t('Menu'),
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
                  subtitle: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        'Calories: ${meal['calories']} kcal',
                      ),
                      Text(
                        'Tinh bột: ${meal['carbs'] ?? 0}g',
                      ),
                      Text(
                        'Đạm: ${meal['protein'] ?? 0}g',
                      ),
                      Text(
                        'Chất béo: ${meal['fat'] ?? 0}g',
                      ),
                      Text(
                        'Chất xơ: ${meal['fiber'] ?? 0}g',
                      ),
                    ],
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
      body: Stack(
        children: [
          _selectedIndex == 2
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

          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                final provider =
                    Provider.of<
                      LocaleProvider
                    >(
                      context,
                      listen: false,
                    );
                if (provider
                        .locale
                        .languageCode ==
                    'vi') {
                  provider.setLocale(
                    const Locale('en'),
                  );
                } else {
                  provider.setLocale(
                    const Locale('vi'),
                  );
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                        30,
                      ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors
                          .black26,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    Text(
                      Provider.of<LocaleProvider>(
                                context,
                              ).locale.languageCode ==
                              'vi'
                          ? 'VI'
                          : 'EN',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    AnimatedSwitcher(
                      duration:
                          const Duration(
                            milliseconds:
                                300,
                          ),
                      transitionBuilder:
                          (
                            child,
                            animation,
                          ) {
                            return ScaleTransition(
                              scale:
                                  animation,
                              child:
                                  child,
                            );
                          },
                      child: Text(
                        Provider.of<
                                      LocaleProvider
                                    >(context)
                                    .locale
                                    .languageCode ==
                                'vi'
                            ? '🇻🇳'
                            : '🇺🇸',
                        key: ValueKey(
                          Provider.of<
                                LocaleProvider
                              >(context)
                              .locale
                              .languageCode,
                        ),
                        style:
                            const TextStyle(
                              fontSize:
                                  18,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                label: Lang.t('home'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.history,
                ),
                label: Lang.t(
                  'history',
                ),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.fitness_center,
                ),
                label: Lang.t(
                  'workout',
                ),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.group,
                ),
                label: Lang.t('group'),
              ),
            ],
          ),
    );
  }

  void _themmonan() {
    final List<Map<String, dynamic>>
    availableMeals = [
      {
        'name': 'Cơm',
        'calories': 130,
        'carbs': 28.0,
        'protein': 2.5,
        'fat': 0.3,
        'fiber': 0.2,
      },
      {
        'name': 'Phở bò',
        'calories': 400,
        'carbs': 45.0,
        'protein': 20.0,
        'fat': 10.0,
        'fiber': 2.0,
      },
      {
        'name': 'Trứng luộc',
        'calories': 75,
        'carbs': 0.6,
        'protein': 6.3,
        'fat': 5.3,
        'fiber': 0.0,
      },
      {
        'name': 'Chuối',
        'calories': 200,
        'carbs': 50.0,
        'protein': 1.0,
        'fat': 1.0,
        'fiber': 3.0,
      },
      {
        'name': 'Sữa tươi',
        'calories': 150,
        'carbs': 12.0,
        'protein': 8.0,
        'fat': 8.0,
        'fiber': 0.0,
      },
      {
        'name': 'Bánh mì',
        'calories': 250,
        'carbs': 45.0,
        'protein': 8.0,
        'fat': 3.0,
        'fiber': 2.0,
      },
      {
        'name': 'Cá hồi',
        'calories': 300,
        'carbs': 0.0,
        'protein': 25.0,
        'fat': 20.0,
        'fiber': 0.0,
      },
      {
        'name': 'Cà chua',
        'calories': 30,
        'carbs': 7.0,
        'protein': 1.0,
        'fat': 0.2,
        'fiber': 1.5,
      },
      {
        'name': 'Chè đỗ đen',
        'calories': 420,
        'carbs': 80.0,
        'protein': 10.0,
        'fat': 5.0,
        'fiber': 6.0,
      },
      {
        'name': 'Lạc rang',
        'calories': 300,
        'carbs': 8.0,
        'protein': 13.0,
        'fat': 25.0,
        'fiber': 3.0,
      },
      {
        'name': 'Ổi',
        'calories': 80,
        'carbs': 14.0,
        'protein': 1.0,
        'fat': 0.5,
        'fiber': 5.0,
      },
    ];

    String? selectedMealName;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? localSelectedMeal =
            selectedMealName;
        String searchQuery = '';

        return AlertDialog(
          title: Text(
            Lang.t('food_list'),
          ),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              final filteredMeals =
                  availableMeals.where((
                    meal,
                  ) {
                    final name =
                        meal['name']
                            .toString()
                            .toLowerCase();
                    return name.contains(
                      searchQuery
                          .toLowerCase(),
                    );
                  }).toList();

              return Column(
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: Lang.t(
                        'search_menu',
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                    onChanged: (value) {
                      setStateDialog(
                        () {
                          searchQuery =
                              value;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButton<
                    String
                  >(
                    value:
                        localSelectedMeal,
                    hint: Text(
                      Lang.t(
                        'choose_meal',
                      ),
                    ),
                    isExpanded: true,
                    items: filteredMeals.map((
                      meal,
                    ) {
                      return DropdownMenuItem<
                        String
                      >(
                        value:
                            meal['name']
                                as String,
                        child: Text(
                          meal['name']
                              as String,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setStateDialog(() {
                        localSelectedMeal =
                            value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                Lang.t('cancel'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (localSelectedMeal !=
                    null) {
                  final selectedMeal =
                      availableMeals.firstWhere(
                        (meal) =>
                            meal['name'] ==
                            localSelectedMeal,
                      );

                  setState(() {
                    _meals.add(
                      selectedMeal,
                    );
                    selectedMealName =
                        localSelectedMeal;
                  });
                }
                Navigator.pop(context);
              },
              child: Text(
                Lang.t('add'),
              ),
            ),
          ],
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
      case 'carbohydrates':
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
