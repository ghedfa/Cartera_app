import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'package:budget_manager_app/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/transaction_cubit.dart';
import 'base_screen.dart';
import 'wishlist_screen.dart';
import 'add_item_screen.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart';
import 'password_success_screen.dart';
import 'profile_screen.dart';
import 'personal_info_screen.dart';
import 'welcome.dart';
import 'firebase_options.dart';
import 'change_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }
  Bloc.observer = SimpleBlocObserver(); // Monitor state changes (Optional)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TransactionCubit()..loadTransactions()),
        // Add other Cubits or Blocs here as your app grows
      ],
      child: MaterialApp(
        title: 'Budget Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasData && snapshot.data != null) {
              return const BaseScreen();
            }
            
            return const Welcome2Screen();
          },
        ),
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

/// App routes configuration
class AppRoutes {
  static final routes = {
    '/welcome': (context) => const Welcome2Screen(),
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignUpScreen(),
    '/forgot-password': (context) => const ForgotPasswordScreen(),
    '/password-success': (context) => const PasswordSuccessScreen(),
    '/base': (context) => const BaseScreen(),
    '/base-wishlist': (context) => const BaseScreen(initialIndex: 1),
    '/base-profile': (context) => const BaseScreen(initialIndex: 2),
    '/wishlist': (context) => const WishlistScreen(),
    '/add-item': (context) => const AddItemScreen(),
    '/profile': (context) => const ProfileScreen(),
    '/personal-info': (context) => const PersonalInfoScreen(),
    '/home': (context) => const BaseScreen(),
    '/change-password': (context) =>
        const ChangePasswordScreen(), // New route for password change
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
