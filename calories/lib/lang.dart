import 'package:flutter/material.dart';

class Lang {
  static String currentLang = 'vi';

  static Map<String, Map<String, String>> data = {
    'vi': {
      'hello': 'Xin chào',
      'calculate_bmi_tdee': 'Tính BMI & TDEE',
      'full_name': 'Họ và tên',
      'height': 'Chiều cao (cm)',
      'weight': 'Cân nặng (kg)',
      'age': 'Tuổi',
      'calculate': 'Tính BMI & TDEE',
      'monday': 'Thứ Hai',
      'tuesday': 'Thứ Ba',
      'wednesday': 'Thứ Tư',
      'thursday': 'Thứ Năm',
      'friday': 'Thứ Sáu',
      'saturday': 'Thứ Bảy',
      'sunday': 'Chủ Nhật',
      'tdee_label': 'TDEE:',
      'calories_per_day': 'kcal/ngày',
      'today_progress': 'Tiến độ hôm nay:',
      'today_nutrition': 'Giá trị dinh dưỡng hôm nay:',
      'carbs': 'Tinh bột',
      'protein': 'Đạm',
      'fat': 'Chất béo',
      'fiber': 'Chất xơ',
      'Menu': 'Danh sách món đã ăn:',
      'calories': 'Calo',
      'calories_unit': 'kcal',
      'home': 'Trang chủ',
      'history': 'Lịch sử',
      'workout': 'Luyện tập',
      'group': 'Thông tin nhóm',
      'search_menu': 'Tìm món...',
      'food_list': 'Chọn món ăn',
      'choose_meal': 'Chọn món...',
      'cancel': 'Hủy',
      'add': 'Thêm',
      'workout_plan': 'Danh sách bài tập',
    },
    'en': {
      'hello': 'Hello',
      'calculate_bmi_tdee': 'Calculate BMI & TDEE',
      'full_name': 'Full name',
      'height': 'Height (cm)',
      'weight': 'Weight (kg)',
      'age': 'Age',
      'calculate': 'Calculate BMI & TDEE',
      'monday': 'Monday',
      'tuesday': 'Tuesday',
      'wednesday': 'Wednesday',
      'thursday': 'Thursday',
      'friday': 'Friday',
      'saturday': 'Saturday',
      'sunday': 'Sunday',
      'tdee_label': 'TDEE:',
      'calories_per_day': 'kcal/day',
      'today_progress': 'Today\'s progress:',
      'today_nutrition': 'Today\'s nutrition values:',
      'carbs': 'Carbohydrates',
      'protein': 'Protein',
      'fat': 'Fat',
      'fiber': 'Fiber',
      'Menu': 'Menu:',
      'calories': 'Calories',
      'calories_unit': 'kcal',
      'home': 'Home',
      'history': 'History',
      'workout': 'Workout',
      'group': 'Group',
      'food_list': 'Food List',
      'search_menu': 'Search Menu...',
      'choose_meal': 'Choose meal...',
      'cancel': 'Cancel',
      'add': 'Add',
      'workout_plan': 'Workout Plan',
    },
  };

  static String t(String key) {
    return data[currentLang]?[key] ?? data['en']?[key] ?? key;
  }

  static void switchLang() {
    currentLang = currentLang == 'vi' ? 'en' : 'vi';
  }
}

class LanguageButton extends StatefulWidget {
  final VoidCallback onChanged;
  const LanguageButton({super.key, required this.onChanged});

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _rotation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLang() {
    _controller.forward(from: 0);
    setState(() {
      Lang.switchLang();
    });
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final bool isVietnamese = Lang.currentLang == 'vi';
    final String langCode = isVietnamese ? 'VI' : 'EN';
    final String flag = isVietnamese ? '🇻🇳' : '🇺🇸';

    return GestureDetector(
      onTap: _toggleLang,
      child: RotationTransition(
        turns: _rotation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                langCode,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 6),
              Text(flag, style: const TextStyle(fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }
}
