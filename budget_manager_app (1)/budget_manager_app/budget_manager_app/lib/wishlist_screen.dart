import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'services/wishlist_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistService _wishlistService = WishlistService();
  double totalSavings = 0.0;
  bool _isLoading = true;
  Map<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>> groupedItems = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Listen to wishlist updates
      _wishlistService.getWishlistItems().listen((snapshot) async {
        final grouped = await _wishlistService.getWishlistItemsByMonth();
        final total = await _wishlistService.getTotalSavingsGoal();
        
        if (mounted) {
          setState(() {
            groupedItems = grouped;
            totalSavings = total;
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading wishlist: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B7BE5),
      appBar: null,
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
                    'Wishlist',
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
                    child: Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined,
                              color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Total Saving Amount Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'Total Saving',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${totalSavings.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Motivational Quote
            Container(
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.lightbulb_outline,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Save Today, Own Tomorrow. Every Dollar You Set Aside Brings Your Dreams One Step Closer.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Wishlist Items
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : groupedItems.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.list_alt,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No items in your wishlist',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap + to add your first item',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: groupedItems.length,
                            itemBuilder: (context, index) {
                              final monthYear = groupedItems.keys.elementAt(index);
                              final items = groupedItems[monthYear]!;
                              final date = DateTime(
                                int.parse(monthYear.split('-')[1]),
                                int.parse(monthYear.split('-')[0]),
                              );
                              
                              return _buildMonthSection(
                                DateFormat('MMMM yyyy').format(date),
                                items.map((doc) {
                                  final data = doc.data();
                                  return _buildWishlistItem(
                                    data['title'] as String,
                                    (data['amount'] as num).toDouble(),
                                    IconData(
                                      int.parse(data['icon']),
                                      fontFamily: 'MaterialIcons',
                                    ),
                                    Color(int.parse('0xFF${data['iconColor']}')),
                                    data['progress'] as double? ?? 0.0,
                                    doc.id,
                                  );
                                }).toList(),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7AA4FF).withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF7AA4FF), Color(0xFF4B7BE5)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Add a small scale animation when pressed
            HapticFeedback.mediumImpact();
            Navigator.pushNamed(context, '/add-item');
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildMonthSection(String month, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_month,
              size: 20,
              color: Color(0xFF7AA4FF),
            ),
            const SizedBox(width: 8),
            Text(
              month,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...items,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildWishlistItem(
      String name, double amount, IconData icon, Color iconColor, double progress, String itemId) {
    return Dismissible(
      key: Key(itemId),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Item'),
              content: const Text('Are you sure you want to delete this item?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) async {
        try {
          await _wishlistService.deleteWishlistItem(itemId);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting item: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: GestureDetector(
        onTap: () async {
          final newProgress = await showDialog<double>(
            context: context,
            builder: (BuildContext context) {
              double tempProgress = progress;
              return AlertDialog(
                title: const Text('Update Progress'),
                content: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${(tempProgress * 100).toStringAsFixed(0)}%'),
                        Slider(
                          value: tempProgress,
                          onChanged: (value) {
                            setState(() {
                              tempProgress = value;
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, tempProgress),
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );

          if (newProgress != null && mounted) {
            try {
              await _wishlistService.updateItemProgress(itemId, newProgress);
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error updating progress: ${e.toString()}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
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
            border: Border.all(
              color: const Color(0xFFEDF2FF),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: const Color(0xFFEDF2FF),
                      valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7AA4FF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
