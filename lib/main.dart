import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'views/login_view.dart';
import 'views/character_view.dart';

final FlutterLocalNotificationsPlugin
    flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('favorite_spells');

  const AndroidInitializationSettings
      initializationSettingsAndroid =
      AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );

  const InitializationSettings
      initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin
      .initialize(initializationSettings);

  final prefs =
      await SharedPreferences.getInstance();

  bool isLogin =
      prefs.getBool('isLogin') ?? false;

  runApp(
    MyApp(
      isLogin: isLogin,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLogin;

  const MyApp({
    super.key,
    required this.isLogin,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      home: isLogin
          ? CharacterView()
          : LoginView(),
    );
  }
}