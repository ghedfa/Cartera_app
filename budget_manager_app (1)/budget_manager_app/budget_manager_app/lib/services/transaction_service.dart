import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Get user's transaction collection reference
  CollectionReference<Map<String, dynamic>> _getUserTransactionsRef() {
    return _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('transactions');
  }

  // Add a new transaction
  Future<void> addTransaction(Map<String, dynamic> transaction) async {
    if (currentUserId == null) return;

    await _getUserTransactionsRef().add({
      ...transaction,
      'timestamp': FieldValue.serverTimestamp(),
      'type': transaction['isExpense'] ? 'expense' : 'income',
    });
  }

  // Update an existing transaction
  Future<void> updateTransaction(String transactionId, Map<String, dynamic> transaction) async {
    if (currentUserId == null) return;

    await _getUserTransactionsRef().doc(transactionId).update(transaction);
  }

  // Delete a transaction
  Future<void> deleteTransaction(String transactionId) async {
    if (currentUserId == null) return;

    await _getUserTransactionsRef().doc(transactionId).delete();
  }

  // Get all transactions
  Stream<QuerySnapshot<Map<String, dynamic>>> getTransactions() {
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    return _getUserTransactionsRef()
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Get transactions by type (expense or income)
  Stream<QuerySnapshot<Map<String, dynamic>>> getTransactionsByType(bool isExpense) {
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    return _getUserTransactionsRef()
        .where('type', isEqualTo: isExpense ? 'expense' : 'income')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Get transactions for a specific month
  Stream<QuerySnapshot<Map<String, dynamic>>> getTransactionsByMonth(DateTime date) {
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    DateTime startOfMonth = DateTime(date.year, date.month, 1);
    DateTime startOfNextMonth = DateTime(date.year, date.month + 1, 1);

    return _getUserTransactionsRef()
        .where('timestamp', isGreaterThanOrEqualTo: startOfMonth)
        .where('timestamp', isLessThan: startOfNextMonth)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Get total balance
  Future<double> getTotalBalance() async {
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    QuerySnapshot<Map<String, dynamic>> snapshot = await _getUserTransactionsRef().get();
    
    double total = 0;
    for (var doc in snapshot.docs) {
      var data = doc.data();
      double amount = (data['amount'] as num).toDouble();
      if (data['type'] == 'expense') {
        total -= amount;
      } else {
        total += amount;
      }
    }
    
    return total;
  }

  // Get monthly summary
  Future<Map<String, double>> getMonthlySummary(DateTime date) async {
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    DateTime startOfMonth = DateTime(date.year, date.month, 1);
    DateTime startOfNextMonth = DateTime(date.year, date.month + 1, 1);

    QuerySnapshot<Map<String, dynamic>> snapshot = await _getUserTransactionsRef()
        .where('timestamp', isGreaterThanOrEqualTo: startOfMonth)
        .where('timestamp', isLessThan: startOfNextMonth)
        .get();

    double totalIncome = 0;
    double totalExpense = 0;

    for (var doc in snapshot.docs) {
      var data = doc.data();
      double amount = (data['amount'] as num).toDouble();
      if (data['type'] == 'expense') {
        totalExpense += amount;
      } else {
        totalIncome += amount;
      }
    }

    return {
      'income': totalIncome,
      'expense': totalExpense,
      'balance': totalIncome - totalExpense,
    };
  }
}
