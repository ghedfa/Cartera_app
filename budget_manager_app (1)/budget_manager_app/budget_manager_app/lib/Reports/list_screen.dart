import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  // Helper function to get icon and color based on category
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
    // List of transactions with different categories
    final List<Map<String, dynamic>> transactions = [
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

    return Scaffold(
      backgroundColor: const Color(0xFF4B7BE5),
      body: Column(
        children: [
          // Top bar (Back icon, title, and notification icon)
          Container(
            padding:
                const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.white,
                ),
                const Text(
                  'Transactions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                  color: Colors.white,
                ),
              ],
            ),
          ),

          // Content area (List of items)
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // List of items
                    Expanded(
                      child: ListView.separated(
                        itemCount: transactions.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Icon container
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFEFEF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child:
                                      _getCategoryIcon(transaction['category']),
                                ),
                                const SizedBox(width: 16),
                                // Text details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transaction['category'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        transaction['description'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        transaction['date'],
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Amount text
                                Text(
                                  transaction['amount'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF4B7BE5),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
