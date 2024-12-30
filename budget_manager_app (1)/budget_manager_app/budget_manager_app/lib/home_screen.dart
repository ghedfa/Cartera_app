import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/transaction_service.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final TransactionService _transactionService = TransactionService();
  bool isExpenseMode = true;
  bool isModifyMode = false;
  double balance = 0.0;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> transactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    _transactionService.getTransactions().listen((snapshot) {
      setState(() {
        transactions = snapshot.docs;
        isLoading = false;
        _updateBalance();
      });
    });
  }

  void _updateBalance() async {
    final balance = await _transactionService.getTotalBalance();
    setState(() {
      this.balance = balance;
    });
  }

  // Define expense categories with their icons and colors
  final Map<String, Map<String, dynamic>> expenseCategories = {
    'Food': {'icon': Icons.restaurant, 'color': const Color(0xFFFF7AA4)},
    'Travel': {'icon': Icons.directions_car, 'color': const Color(0xFF7AA4FF)},
    'Shopping': {'icon': Icons.shopping_bag, 'color': const Color(0xFFFFA07A)},
    'Entertainment': {'icon': Icons.movie, 'color': const Color(0xFF98FB98)},
    'Health': {'icon': Icons.medical_services, 'color': const Color(0xFFDDA0DD)},
    'Education': {'icon': Icons.school, 'color': const Color(0xFF87CEEB)},
    'Bills': {'icon': Icons.receipt_long, 'color': const Color(0xFFFFD700)},
    'Others': {'icon': Icons.more_horiz, 'color': const Color(0xFFA9A9A9)},
  };

  // Define income categories with their icons and colors
  final Map<String, Map<String, dynamic>> incomeCategories = {
    'Salary': {'icon': Icons.work, 'color': const Color(0xFF4CAF50)},
    'Freelance': {'icon': Icons.computer, 'color': const Color(0xFF7AA4FF)},
    'Investment': {'icon': Icons.trending_up, 'color': const Color(0xFFFFD700)},
    'Gift': {'icon': Icons.card_giftcard, 'color': const Color(0xFFFF7AA4)},
    'Others': {'icon': Icons.more_horiz, 'color': const Color(0xFFA9A9A9)},
  };

  Map<String, dynamic>? getCategoryData(String category) {
    final categories = isExpenseMode ? expenseCategories : incomeCategories;
    return categories[category];
  }

  IconData getIconForCategory(String category) {
    final categoryData = getCategoryData(category);
    return categoryData?['icon'] as IconData? ?? Icons.more_horiz;
  }

  Color getColorForCategory(String category) {
    final categoryData = getCategoryData(category);
    return categoryData?['color'] as Color? ?? const Color(0xFFA9A9A9);
  }

  void addItem() {
    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    String selectedCategory = isExpenseMode ? 'Others' : 'Others';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final categories = isExpenseMode ? expenseCategories : incomeCategories;
            return AlertDialog(
              title: Text('Add ${isExpenseMode ? 'Expense' : 'Income'}'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: amountController,
                      decoration: const InputDecoration(labelText: 'Amount'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    const Text('Category',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: categories.entries.map<Widget>((entry) {
                        final categoryData = entry.value;
                        return _buildCategoryChip(
                          entry.key,
                          categoryData['icon'] as IconData,
                          categoryData['color'] as Color,
                          selectedCategory,
                          (category) => setState(() => selectedCategory = category),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (titleController.text.isNotEmpty &&
                        amountController.text.isNotEmpty) {
                      final newItem = {
                        'title': titleController.text,
                        'amount': double.tryParse(amountController.text) ?? 0.0,
                        'category': selectedCategory,
                        'isExpense': isExpenseMode,
                      };
                      await _transactionService.addTransaction(newItem);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void editItem(String transactionId, Map<String, dynamic> item) {
    TextEditingController titleController =
        TextEditingController(text: item['title'] as String);
    TextEditingController amountController =
        TextEditingController(text: (item['amount'] as num).toString());
    String selectedCategory = item['category'] as String? ?? 'Others';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final categories = isExpenseMode ? expenseCategories : incomeCategories;
            return AlertDialog(
              title: Text('Edit ${isExpenseMode ? 'Expense' : 'Income'}'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: amountController,
                      decoration: const InputDecoration(labelText: 'Amount'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    const Text('Category',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: categories.entries.map<Widget>((entry) {
                        final categoryData = entry.value;
                        return _buildCategoryChip(
                          entry.key,
                          categoryData['icon'] as IconData,
                          categoryData['color'] as Color,
                          selectedCategory,
                          (category) => setState(() => selectedCategory = category),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (titleController.text.isNotEmpty &&
                        amountController.text.isNotEmpty) {
                      final updatedItem = {
                        'title': titleController.text,
                        'amount': double.tryParse(amountController.text) ?? 0.0,
                        'category': selectedCategory,
                        'isExpense': isExpenseMode,
                      };
                      await _transactionService.updateTransaction(
                          transactionId, updatedItem);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void deleteItem(String transactionId) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: const Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    ) ??
        false;

    if (confirm) {
      await _transactionService.deleteTransaction(transactionId);
    }
  }

  Widget _buildTransactionList() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredTransactions =
        transactions.where((doc) => doc.data()['isExpense'] == isExpenseMode).toList();

    if (filteredTransactions.isEmpty) {
      return Center(
        child: Text(
          'No ${isExpenseMode ? 'expenses' : 'income'} yet',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredTransactions.length,
      itemBuilder: (context, index) {
        final doc = filteredTransactions[index];
        final item = doc.data();
        return _buildTransactionItem(item, doc.id, isModifyMode);
      },
    );
  }

  Widget _buildTransactionItem(
      Map<String, dynamic> item, String transactionId, bool isModifyMode) {
    final category = item['category'] as String? ?? 'Others';
    final categoryColor = getColorForCategory(category);
    final categoryIcon = getIconForCategory(category);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: categoryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              categoryIcon,
              color: categoryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String? ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  item['date'] as String? ?? 'Today',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${(item['amount'] as num?)?.toStringAsFixed(2) ?? '0.00'}',
                style: TextStyle(
                  color: isExpenseMode ? Colors.red : Colors.green,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              if (isModifyMode)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 18),
                      color: Colors.blue,
                      onPressed: () => editItem(transactionId, item),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 18),
                      color: Colors.red,
                      onPressed: () => deleteItem(transactionId),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    String category,
    IconData icon,
    Color color,
    String selectedCategory,
    Function(String) onSelect,
  ) {
    return GestureDetector(
      onTap: () => onSelect(category),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selectedCategory == category ? color : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: selectedCategory == category ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 4),
            Text(
              category,
              style: TextStyle(
                color: selectedCategory == category ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B7BE5),
      body: SafeArea(
        child: Column(
          children: [
            // White Content Section
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    // Total Balance Section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        children: [
                          const Text(
                            'Total Balance',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '\$${balance.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Spending/Income Toggle Section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1.0, vertical: 20.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpenseMode = true;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: isExpenseMode
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Spending',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isExpenseMode
                                            ? Colors.black
                                            : const Color.fromARGB(
                                                255, 214, 205, 205),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpenseMode = false;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: isExpenseMode
                                        ? Colors.transparent
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Income',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isExpenseMode
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // History Section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'History',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add, color: Colors.blue),
                                onPressed: addItem,
                              ),
                              IconButton(
                                icon: Icon(
                                  isModifyMode ? Icons.check : Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isModifyMode = !isModifyMode;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Transactions List
                    Expanded(
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : _buildTransactionList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
