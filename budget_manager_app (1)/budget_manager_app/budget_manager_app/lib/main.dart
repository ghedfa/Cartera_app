import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/transaction_cubit.dart';
import 'wishlist_screen.dart';
import 'add_item_screen.dart';
import 'login_screen.dart';
import 'forgot_password_screen.dart';
import 'security_pin_screen.dart';
import 'signup_screen.dart';
import 'password_success_screen.dart';
import 'profile_screen.dart';
import 'personal_info_screen.dart';
import 'welcome.dart';

void main() {
  Bloc.observer = SimpleBlocObserver(); // Monitor state changes (Optional)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TransactionCubit()..loadTransactions()),
        // Add other Cubits or Blocs here as your app grows
      ],
      child: MaterialApp(
        title: 'Budget Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: '/welcome',
        routes: AppRoutes.routes,
      ),
    );
  }
}

/// Separate file for app routes (routes.dart)
class AppRoutes {
  static final routes = {
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignUpScreen(),
    '/forgot-password': (context) => const ForgotPasswordScreen(),
    '/security-pin': (context) => const SecurityPinScreen(),
    '/password-success': (context) => const PasswordSuccessScreen(),
    '/wishlist': (context) => const WishlistScreen(),
    '/add-item': (context) => const AddItemScreen(),
    '/profile': (context) => const ProfileScreen(),
    '/personal-info': (context) => const PersonalInfoScreen(),
    '/welcome': (context) => const Welcome2Screen(),
  };
}

/// Bloc Observer for Debugging (Optional)
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} state changed: $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('${bloc.runtimeType} error: $error');
  }
}
