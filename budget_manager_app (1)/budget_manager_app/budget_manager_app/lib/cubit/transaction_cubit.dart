import 'package:bloc/bloc.dart';

// Transaction Cubit State
class TransactionState {
  final List<Map<String, dynamic>> transactions;
  TransactionState(this.transactions);
}

// Cubit for transaction management
class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionState([])) {
    loadTransactions(); // Automatically load transactions on creation
  }

  // Add a method to load transactions (simulating fetching from an API or database)
  void loadTransactions() {
    final transactions = [
      {
        'category': 'Restaurant',
        'date': '15/1/2024',
        'amount': '2450.00DA',
        'description': 'Dinner with family'
      },
      {
        'category': 'Transport',
        'date': '14/1/2024',
        'amount': '800.00DA',
        'description': 'Taxi fare'
      },
      {
        'category': 'Shopping',
        'date': '13/1/2024',
        'amount': '5670.50DA',
        'description': 'New clothes'
      },
      {
        'category': 'Groceries',
        'date': '12/1/2024',
        'amount': '1580.04DA',
        'description': 'Weekly groceries'
      },
      {
        'category': 'Entertainment',
        'date': '11/1/2024',
        'amount': '1200.00DA',
        'description': 'Cinema tickets'
      },
      {
        'category': 'Health',
        'date': '10/1/2024',
        'amount': '3500.00DA',
        'description': 'Pharmacy'
      },
      {
        'category': 'Bills',
        'date': '09/1/2024',
        'amount': '4200.00DA',
        'description': 'Electricity bill'
      },
    ];
    emit(TransactionState(transactions));
  }

  // Fetch the first 3 transactions
  List<Map<String, dynamic>> getTopTransactions() {
    return state.transactions.take(3).toList();
  }

  // Fetch the full list of transactions
  List<Map<String, dynamic>> getAllTransactions() {
    return state.transactions;
  }
}
