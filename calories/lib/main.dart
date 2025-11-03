import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'man_hinh_chinh.dart';
import 'quan_ly_ngon_ngu.dart' hide Lang;
import 'lang.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const CalorieAppWrapper(),
    ),
  );
}

class CalorieAppWrapper extends StatelessWidget {
  const CalorieAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), 
      minTextAdapt: true, 
      splitScreenMode: true, 
      builder: (context, child) => const CalorieApp(),
    );
  }
}

class CalorieApp extends StatelessWidget {
  const CalorieApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    Lang.currentLang = provider.locale.languageCode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calorie Counter',
      theme: ThemeData(primarySwatch: Colors.green),

      locale: provider.locale,

      supportedLocales: const [
        Locale('en'),
        Locale('vi'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      home: const ManHinhChinh(),
    );
  }
}
