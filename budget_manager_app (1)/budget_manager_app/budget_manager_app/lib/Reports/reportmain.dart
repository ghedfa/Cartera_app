import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reportsdaily.dart';
import 'reportsweekly.dart';
import 'reportsmonthly.dart';
import 'reportsyearly.dart';
import 'package:budget_manager_app/cubit/transaction_cubit.dart'; // Import the TransactionCubit

class ReportMainScreen extends StatelessWidget {
  const ReportMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionCubit(), // Provide the TransactionCubit here
      child: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/reportsdaily':
              builder = (BuildContext _) => const ReportsdailyScreen();
              break;
            case '/reportsweekly':
              builder = (BuildContext _) => const ReportsweeklyScreen();
              break;
            case '/reportsmonthly':
              builder = (BuildContext _) => const ReportsmonthlyScreen();
              break;
            case '/reportsyearly':
              builder = (BuildContext _) => const ReportsyearlyScreen();
              break;
            default:
              builder = (BuildContext _) => const ReportsdailyScreen();
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}
