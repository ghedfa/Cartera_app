import 'package:budget_manager_app/cubit/transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  // Function to get category icon
  Widget _getCategoryIcon(String category) {
    switch (category) {
      case 'Groceries':
        return const Icon(Icons.shopping_cart,
            size: 30, color: Color(0xFF4B7BE5));
      case 'Transport':
        return const Icon(Icons.directions_car,
            size: 30, color: Color(0xFF4B7BE5));
      case 'Entertainment':
        return const Icon(Icons.movie, size: 30, color: Color(0xFF4B7BE5));
      case 'Shopping':
        return const Icon(Icons.shopping_bag,
            size: 30, color: Color(0xFF4B7BE5));
      case 'Restaurant':
        return const Icon(Icons.restaurant, size: 30, color: Color(0xFF4B7BE5));
      case 'Health':
        return const Icon(Icons.medical_services,
            size: 30, color: Color(0xFF4B7BE5));
      case 'Bills':
        return const Icon(Icons.receipt_long,
            size: 30, color: Color(0xFF4B7BE5));
      default:
        return const Icon(Icons.attach_money,
            size: 30, color: Color(0xFF4B7BE5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Transactions')),
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          // Use the transactions list from the Cubit
          final transactions = state.transactions;

          // If there are no transactions, show a message
          if (transactions.isEmpty) {
            return const Center(child: Text('No transactions available.'));
          }

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: _getCategoryIcon(transaction['category']),
                    title: Text(
                      transaction['category'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      transaction['description'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: Text(
                      transaction['amount'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B7BE5),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
