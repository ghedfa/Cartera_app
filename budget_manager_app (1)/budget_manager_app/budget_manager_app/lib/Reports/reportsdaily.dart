import 'package:budget_manager_app/Reports/list_screen.dart';
import 'package:budget_manager_app/Reports/reportsmonthly.dart';
import 'package:budget_manager_app/Reports/reportsweekly.dart';
import 'package:budget_manager_app/Reports/reportsyearly.dart';
import 'package:budget_manager_app/Reports/search_screen.dart';
import 'package:budget_manager_app/cubit/transaction_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsdailyScreen extends StatefulWidget {
  const ReportsdailyScreen({super.key});

  @override
  State<ReportsdailyScreen> createState() => _ReportsdailyScreenState();
}

class _ReportsdailyScreenState extends State<ReportsdailyScreen> {
  bool isBarChart = true;
  String selectedTab = 'Daily';
  final List<List<double>> dailydata = [
    [7, 10],
    [3, 6],
    [4, 10],
    [5, 8],
    [2, 6],
    [5, 5],
    [7, 8],
  ];

  // Data for pie chart (spending categories)
  final List<DailySpendingData> pieData = [
    DailySpendingData(
        'Groceries', 35, const Color(0xFFE3EFF9)), // Lightest Blue
    DailySpendingData(
        'Medications', 15, const Color(0xFFCCE3F7)), // Very Light Blue
    DailySpendingData('Transport', 20, const Color(0xFFB5D7F5)), // Light Blue
    DailySpendingData(
        'Shopping', 10, const Color(0xFF9ECBF3)), // Medium Light Blue
    DailySpendingData('Bills', 12, const Color(0xFF87BFF1)), // Medium Blue
    DailySpendingData(
        'Entertainment', 8, const Color(0xFF70B3EF)), // Medium Dark Blue
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B7BE5),
      body: Column(
        children: [
          // Top bar with glass morphism effect
          Container(
            padding:
                const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF4B7BE5).withOpacity(0.95),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 1,
                ),
                Text(
                  'Reports',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                Icon(Icons.notifications_none_rounded,
                    color: Colors.white, size: 24),
              ],
            ),
          ),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Enhanced Tab buttons with animation
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTabButton('Daily',
                              isSelected: selectedTab == 'Daily'),
                          _buildTabButton('Weekly',
                              isSelected: selectedTab == 'Weekly'),
                          _buildTabButton('Monthly',
                              isSelected: selectedTab == 'Monthly'),
                          _buildTabButton('Yearly',
                              isSelected: selectedTab == 'Yearly'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Chart Container
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          // Chart Box
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: isBarChart
                                    ? Column(
                                        children: [
                                          // Search and Filter Row
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Enhanced Budget/Spending Toggle
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.03),
                                                      blurRadius: 8,
                                                      offset:
                                                          const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10,
                                                          horizontal: 20),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: const Text(
                                                        'Budget',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 6),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10,
                                                          horizontal: 20),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFF4B7BE5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color(
                                                                    0xFF4B7BE5)
                                                                .withOpacity(
                                                                    0.3),
                                                            blurRadius: 8,
                                                            offset:
                                                                const Offset(
                                                                    0, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      child: const Text(
                                                        'Spending',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Enhanced Search Icon
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.03),
                                                        blurRadius: 8,
                                                        offset:
                                                            const Offset(0, 2),
                                                      ),
                                                    ],
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const SearchScreen()),
                                                      );
                                                    },
                                                    child: Icon(
                                                        Icons.search_rounded,
                                                        color: Colors.grey[700],
                                                        size: 22),
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          // Bar Chart
                                          Expanded(
                                            child: BarChart(
                                              BarChartData(
                                                maxY:
                                                    10, // Increased to show the full range of monthly data
                                                minY: 0,
                                                gridData: FlGridData(
                                                  show: true,
                                                  drawHorizontalLine: true,
                                                  drawVerticalLine: false,
                                                  getDrawingHorizontalLine:
                                                      (value) => FlLine(
                                                    color: Colors.grey[200]!,
                                                    strokeWidth: 1,
                                                    dashArray: [5, 5],
                                                  ),
                                                ),
                                                borderData:
                                                    FlBorderData(show: false),
                                                titlesData: FlTitlesData(
                                                  leftTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                      showTitles: true,
                                                      reservedSize: 30,
                                                      getTitlesWidget:
                                                          (value, meta) {
                                                        return Text(
                                                          '${value.toInt()}k',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontSize: 12,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  bottomTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                      showTitles: true,
                                                      getTitlesWidget:
                                                          (value, meta) {
                                                        final years = [
                                                          'sun',
                                                          'mon',
                                                          'tue',
                                                          'wed',
                                                          'thu',
                                                          'fri',
                                                          'sat',
                                                        ];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 8.0),
                                                          child: Text(
                                                            years[
                                                                value.toInt()],
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  topTitles: const AxisTitles(
                                                      sideTitles: SideTitles(
                                                          showTitles: false)),
                                                  rightTitles: const AxisTitles(
                                                      sideTitles: SideTitles(
                                                          showTitles: false)),
                                                ),
                                                barGroups: dailydata
                                                    .asMap()
                                                    .entries
                                                    .map((entry) {
                                                  return BarChartGroupData(
                                                    x: entry.key,
                                                    barRods: [
                                                      BarChartRodData(
                                                        toY: entry.value[0],
                                                        color: const Color(
                                                            0xFF4B7BE5),
                                                        width: 8,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        4)),
                                                      ),
                                                      BarChartRodData(
                                                        toY: entry.value[1],
                                                        color: const Color(
                                                            0xFFE1E1E1),
                                                        width: 8,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        4)),
                                                      ),
                                                    ],
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          // Pie Chart Section with Legend on Left
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.05),
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  // Legend Column on Left
                                                  Expanded(
                                                    flex: 6,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children:
                                                            pieData.map((data) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        4),
                                                            child:
                                                                _buildLegendItem(
                                                              data.day,
                                                              data.color,
                                                              '${data.percentage.toStringAsFixed(0)}%',
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  // Pie Chart on Right
                                                  Expanded(
                                                    flex: 4,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AspectRatio(
                                                        aspectRatio: 1,
                                                        child: PieChart(
                                                          PieChartData(
                                                            sectionsSpace: 1,
                                                            centerSpaceRadius:
                                                                20,
                                                            sections: pieData
                                                                .map((data) {
                                                              return PieChartSectionData(
                                                                color:
                                                                    data.color,
                                                                value: data
                                                                    .percentage
                                                                    .toDouble(),
                                                                title: '',
                                                                radius: 35,
                                                                titleStyle:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Enhanced Toggle Button
                          Container(
                            height: 48,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isBarChart = !isBarChart;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4B7BE5),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 4,
                                shadowColor:
                                    const Color(0xFF4B7BE5).withOpacity(0.5),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    isBarChart ? 'Circle' : 'Bar Chart',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.swap_horiz_rounded,
                                      color: Colors.white, size: 22),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Transactions List
                          Expanded(
                            flex: 2,
                            child:
                                BlocBuilder<TransactionCubit, TransactionState>(
                              builder: (context, state) {
                                // Access the Cubit and get the transactions
                                final transactions = context
                                    .read<TransactionCubit>()
                                    .getTopTransactions();

                                // Call your function to build the list with the transactions from the Cubit
                                return _buildTransactionsList(
                                    transactions); // Pass transactions to your list builder
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
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(List<Map<String, dynamic>> transactions) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Your Top Spendings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.shopping_cart,
                              color: Color(0xFF4B7BE5), size: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction['category'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                transaction['date'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListScreen()),
                );
              },
              child: const Text(
                'See More?',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4B7BE5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = label;
        });
        // Handle tab change
        switch (label) {
          case 'Daily':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ReportsdailyScreen()),
            );
            break;
          case 'Weekly':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ReportsweeklyScreen()),
            );
            break;
          case 'Monthly':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ReportsmonthlyScreen()),
            );
            break;
          case 'Yearly':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ReportsyearlyScreen()),
            );
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4B7BE5) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF4B7BE5).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, String percentage) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              percentage,
              style: TextStyle(
                fontSize: 13,
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<BarChartGroupData> _createBarGroups() {
  final List<List<double>> dailydata = [
    [7, 10],
    [3, 6],
    [4, 10],
    [5, 8],
    [2, 6],
    [5, 5],
    [7, 8],
  ];
  return List.generate(dailydata.length, (index) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: dailydata[index][0].toDouble(),
          color: const Color(0xFF4B7BE5),
          width: 8,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
        BarChartRodData(
          toY: dailydata[index][1].toDouble(),
          color: const Color(0xFFE1E1E1),
          width: 8,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  });
}

class DailySpendingData {
  final String day;
  final double percentage;
  final Color color;

  DailySpendingData(this.day, this.percentage, this.color);
}
