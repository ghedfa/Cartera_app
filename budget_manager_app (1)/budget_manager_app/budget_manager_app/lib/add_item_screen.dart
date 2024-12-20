import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  IconData selectedIcon = Icons.shopping_bag_outlined;
  Color selectedColor = const Color(0xFF7AA4FF);

  final List<Map<String, dynamic>> iconOptions = [
    {'icon': Icons.shopping_bag_outlined, 'color': Color(0xFF7AA4FF)},
    {'icon': Icons.flight_takeoff, 'color': Color(0xFFFF7AA4)},
    {'icon': Icons.phone_iphone, 'color': Color(0xFF98FB98)},
    {'icon': Icons.coffee_maker, 'color': Color(0xFFFFA07A)},
    {'icon': Icons.book, 'color': Color(0xFFDDA0DD)},
    {'icon': Icons.laptop_mac, 'color': Color(0xFF20B2AA)},
    {'icon': Icons.directions_car, 'color': Color(0xFFFFB6C1)},
    {'icon': Icons.home, 'color': Color(0xFFFFD700)},
  ];

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('MMMM dd, yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B7BE5),
      body: SafeArea(
        child: Column(
          children: [
            // Simple Top Bar with Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Add Item',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Form Content
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      
                      // Icon Selection
                      Text(
                        'Choose Icon',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: iconOptions.length,
                          itemBuilder: (context, index) {
                            final option = iconOptions[index];
                            final isSelected = option['icon'] == selectedIcon;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIcon = option['icon'];
                                  selectedColor = option['color'];
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? option['color'].withOpacity(0.2)
                                      : Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: isSelected
                                      ? Border.all(color: option['color'])
                                      : null,
                                ),
                                child: Icon(
                                  option['icon'],
                                  color: isSelected
                                      ? option['color']
                                      : Colors.grey,
                                  size: 24,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 24),
                      _buildLabel('Date'),
                      _buildInputField(
                        controller: _dateController,
                        hintText: 'Select Date',
                        suffixIcon: Icons.calendar_today,
                        readOnly: true,
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2025),
                          );
                          if (picked != null) {
                            setState(() {
                              _dateController.text = 
                                  DateFormat('MMMM dd, yyyy').format(picked);
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 20),
                      _buildLabel('Amount'),
                      _buildInputField(
                        controller: _amountController,
                        hintText: '\$0.00',
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.attach_money,
                      ),

                      const SizedBox(height: 20),
                      _buildLabel('Item Title'),
                      _buildInputField(
                        controller: _titleController,
                        hintText: 'Enter item title',
                        prefixIcon: selectedIcon,
                        iconColor: selectedColor,
                      ),

                      const SizedBox(height: 20),
                      _buildLabel('Enter Message (Optional)'),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDF2FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFE0E7FF),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _messageController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Add notes about your saving goal...',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.black38,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement save functionality
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7AA4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    IconData? suffixIcon,
    IconData? prefixIcon,
    Color? iconColor,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDF2FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E7FF),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.black38,
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: iconColor ?? Colors.black38,
                  size: 20,
                )
              : null,
          suffixIcon: suffixIcon != null
              ? Icon(
                  suffixIcon,
                  color: Colors.black38,
                  size: 20,
                )
              : null,
        ),
      ),
    );
  }
}
