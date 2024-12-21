import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'wishlist_screen.dart';
import 'widgets/custom_top_bar.dart';
import 'package:flutter/material.dart';
import '../API/chatbot.dart'; // Import your chatbot page
import 'notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<Map<String, dynamic>> expenses = [
    {'title': 'Transportation', 'amount': 50.00, 'date': 'Today'},
    {'title': 'Food', 'amount': 15.00, 'date': 'Yesterday'},
  ];

  List<Map<String, dynamic>> incomes = [
    {'title': 'Salary', 'amount': 2000.00, 'date': 'Today'},
    {'title': 'Freelance Work', 'amount': 500.00, 'date': 'Yesterday'},
  ];

  bool isExpenseMode = true; // Toggles between expenses and incomes
  bool isModifyMode = false; // Toggles modify mode
  double totalBalance = 0.0;

  @override
  void initState() {
    super.initState();
    calculateBalance(); // Initial calculation of balance
  }
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WishlistScreen()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
          break;
      }
    });
  }

  // Calculate total income, expenses, and balance
  void calculateBalance() {
    double totalIncome =
        incomes.fold(0, (sum, item) => sum + (item['amount'] as double));
    double totalExpenses =
        expenses.fold(0, (sum, item) => sum + (item['amount'] as double));
    setState(() {
      totalBalance = totalIncome - totalExpenses;
    });
  }

  // Toggles between expense and income view
  void toggleMode() {
    setState(() {
      isExpenseMode = !isExpenseMode;
    });
  }

  // Toggles modify mode
  void toggleModifyMode() {
    setState(() {
      isModifyMode = !isModifyMode;
    });
  }

  // Deletes an item from the active list and updates the balance
  void deleteItem(int index) {
    setState(() {
      if (isExpenseMode) {
        expenses.removeAt(index);
      } else {
        incomes.removeAt(index);
      }
      calculateBalance(); // Recalculate balance
    });
  }

  // Edits an item in the active list and updates the balance
  void editItem(int index) {
    TextEditingController titleController = TextEditingController(
        text:
            isExpenseMode ? expenses[index]['title'] : incomes[index]['title']);
    TextEditingController amountController = TextEditingController(
        text: isExpenseMode
            ? expenses[index]['amount'].toString()
            : incomes[index]['amount'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ${isExpenseMode ? 'Expense' : 'Income'}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (isExpenseMode) {
                    expenses[index]['title'] = titleController.text;
                    expenses[index]['amount'] =
                        double.tryParse(amountController.text) ?? 0.0;
                  } else {
                    incomes[index]['title'] = titleController.text;
                    incomes[index]['amount'] =
                        double.tryParse(amountController.text) ?? 0.0;
                  }
                  calculateBalance(); // Recalculate balance
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Adds a new item to the active list and updates the balance
  void addItem() {
    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add ${isExpenseMode ? 'Expense' : 'Income'}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (isExpenseMode) {
                    expenses.add({
                      'title': titleController.text,
                      'amount': double.tryParse(amountController.text) ?? 0.0,
                      'date': 'Today',
                    });
                  } else {
                    incomes.add({
                      'title': titleController.text,
                      'amount': double.tryParse(amountController.text) ?? 0.0,
                      'date': 'Today',
                    });
                  }
                  calculateBalance(); // Recalculate balance
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> activeList = isExpenseMode ? expenses : incomes;

    return Scaffold(
      backgroundColor: const Color(0xFF4B7BE5),
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Wallet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
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
                          Text(
                            'Total Balance',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '\$${totalBalance.toStringAsFixed(2)}',
                            style: TextStyle(
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
                                  if (!isExpenseMode) toggleMode();
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
                                  if (isExpenseMode) toggleMode();
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
                          Text(
                            'History',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.blue),
                                onPressed: addItem,
                              ),
                              IconButton(
                                icon: Icon(
                                  isModifyMode ? Icons.check : Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: toggleModifyMode,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Transactions List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: activeList.length,
                        itemBuilder: (context, index) {
                          return _buildTransactionItem(
                              activeList[index], index, isModifyMode);
                        },
                      ),
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

  Widget _buildTransactionItem(
      Map<String, dynamic> item, int index, bool isModifyMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                item['date'],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '\$${item['amount'].toStringAsFixed(2)}',
                style: TextStyle(
                  color: isExpenseMode ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (isModifyMode) ...[
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => editItem(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteItem(index),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
