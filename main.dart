import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram/auth/auth.dart';
import 'package:nutrigram/camera/camera.dart';
import 'package:nutrigram/firebase_options.dart';
import 'package:nutrigram/info_pages/goals_page.dart';
import 'package:nutrigram/pages/home_page.dart';
import 'package:nutrigram/pages/page_view.dart';
import 'package:nutrigram/pages/settings_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SettingsPage());
  }
}
