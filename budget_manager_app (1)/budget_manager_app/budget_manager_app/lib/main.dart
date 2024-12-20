import 'package:flutter/material.dart';
import 'wishlist_screen.dart';
import 'add_item_screen.dart';
import 'login_screen.dart';
import 'forgot_password_screen.dart';
import 'security_pin_screen.dart';
import 'signup_screen.dart';
import 'password_success_screen.dart';
import 'profile_screen.dart';
import 'personal_info_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/security-pin': (context) => const SecurityPinScreen(),
        '/password-success': (context) => const PasswordSuccessScreen(),
        '/wishlist': (context) => const WishlistScreen(),
        '/add-item': (context) => const AddItemScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/personal-info': (context) => const PersonalInfoScreen(),
      },
    );
  }
}
