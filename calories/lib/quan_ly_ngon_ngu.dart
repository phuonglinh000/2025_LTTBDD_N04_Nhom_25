import 'package:flutter/material.dart';

class LocaleProvider
    extends ChangeNotifier {
  Locale _locale = const Locale('vi');
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    Lang.currentLang =
        locale.languageCode;
    notifyListeners();
  }
}

class Lang {
  static String currentLang = 'vi';

  static final Map<
    String,
    Map<String, String>
  >
  translations = {
    'vi': {
      'hello': 'Xin chào',
      'calculate_bmi_tdee':
          'Tính BMI & TDEE',
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
      'today_progress':
          'Tiến độ hôm nay:',
      'today_nutrition':
          'Giá trị dinh dưỡng hôm nay:',
      'carbs': 'Tinh bột',
      'protein': 'Đạm',
      'fat': 'Chất béo',
      'fiber': 'Chất xơ',
      'Menu': 'Danh sách món đã ăn:',
      'calories': 'Calo',
      'calories_unit': 'kcal',
      'home': 'Trang chủ',
      'history': 'Lịch sử',
      'workout': 'Tập luyện',
      'group': 'Thông tin nhóm',
      'search_menu': 'Tìm món...',
      'food_list': 'Chọn món ăn',
      'choose_meal': 'Chọn món...',
      'cancel': 'Hủy',
      'add': 'Thêm',
      'workout_plan':
          'Danh sách bài tập',
      'newbie': 'Dành cho người mới',
      'full_body_burn':
          'Giảm cân toàn thân',
      'belly_fat_burn':
          'Đốt cháy mỡ bụng',
      '14_days': '14 ngày',
      '18_days': '18 ngày',
      '28_days': '28 ngày',
      'meal_history': 'Lịch sử ăn uống',
      'rice': 'Cơm',
      'beef_noodle': 'Phở bò',
      'boiled_egg': 'Trứng luộc',
      'banana': 'Chuối',
      'milk': 'Sữa tươi',
      'bread': 'Bánh mì',
      'salmon': 'Cá hồi',
      'tomato': 'Cà chua',
      'black_bean_sweet_soup':
          'Chè đỗ đen',
      'roasted_peanut': 'Lạc rang',
      'guava': 'Ổi',
      'steamed_squid': 'Mực hấp',
      'stir_fried_eel': 'Lươn xào',
      'bmi_underweight': 'Gầy',
      'bmi_normal': 'Bình thường',
      'bmi_overweight': 'Thừa cân',
      'bmi_obese': 'Béo phì',
      'activity_level':
          'Mức độ hoạt động',
      'group_info': 'Thông Tin Nhóm',
      'full_name': 'Họ và tên',
      'student_id': 'Mã sinh viên',
      'note': 'Ghi chú',
      'nutrition_notes':
          'Ghi chú dinh dưỡng',
      'enter_new_note':
          'Nhập ghi chú mới...',
      'edit': 'Chỉnh sửa',
      'no_notes_yet':
          'Chưa có ghi chú nào',
    },
    'en': {
      'hello': 'Hello',
      'calculate_bmi_tdee':
          'Calculate BMI & TDEE',
      'full_name': 'Full name',
      'height': 'Height (cm)',
      'weight': 'Weight (kg)',
      'age': 'Age',
      'calculate':
          'Calculate BMI & TDEE',
      'monday': 'Monday',
      'tuesday': 'Tuesday',
      'wednesday': 'Wednesday',
      'thursday': 'Thursday',
      'friday': 'Friday',
      'saturday': 'Saturday',
      'sunday': 'Sunday',
      'tdee_label': 'TDEE:',
      'calories_per_day': 'kcal/day',
      'today_progress':
          'Today\'s progress:',
      'today_nutrition':
          'Today\'s nutrition values:',
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
      'newbie': 'Newbie',
      'full_body_burn':
          'Full body burn',
      'belly_fat_burn':
          'Belly fat burn',
      '14_days': '14 days',
      '18_days': '18 days',
      '28_days': '28 days',
      'meal_history': 'Meal History',
      'rice': 'Rice',
      'beef_noodle': 'Beef Noodle Soup',
      'boiled_egg': 'Boiled Egg',
      'banana': 'Banana',
      'milk': 'Milk',
      'bread': 'Bread',
      'salmon': 'Salmon',
      'tomato': 'Tomato',
      'black_bean_sweet_soup':
          'Black Bean Sweet Soup',
      'roasted_peanut':
          'Roasted Peanut',
      'guava': 'Guava',
      'steamed_squid': 'Steamed squid',
      'stir_fried_eel':
          'Stir-fried eel',
      'bmi_underweight': 'Underweight',
      'bmi_normal': 'Normal',
      'bmi_overweight': 'Overweight',
      'bmi_obese': 'Obese',
      'activity_level':
          'Activity level',
      'group_info': 'Group Information',
      'full_name': 'Full Name',
      'student_id': 'Student ID',
      'note': 'Notes',
      'nutrition_notes':
          'Nutrition notes',
      'enter_new_note':
          'Enter a new note...',
      'edit': 'Edit',
      'no_notes_yet': 'No notes yet',
    },
  };

  static String t(String key) {
    return translations[currentLang]?[key] ??
        key;
  }
}
