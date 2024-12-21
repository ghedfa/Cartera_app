import 'package:budget_manager_app/cubit/transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Transactions')),
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          final transactions =
              context.read<TransactionCubit>().getAllTransactions();
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  child: ListTile(
                    title: Text(transaction['category']),
                    subtitle: Text(transaction['description']),
                    trailing: Text(transaction['amount']),
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
