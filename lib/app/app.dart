import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/presentation/screens/login_screen.dart';

class TestownikApp extends StatelessWidget {
  const TestownikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testownik',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginScreen(),
    );
  }
}
