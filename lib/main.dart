import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimalsocialapp/auth/auth.dart';
import 'package:minimalsocialapp/firebase_options.dart';

import 'package:minimalsocialapp/theme/light_mode.dart';
import 'package:minimalsocialapp/theme/dark_mode.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
