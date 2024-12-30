import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecurityPinScreen extends StatefulWidget {
  const SecurityPinScreen({super.key});

  @override
  State<SecurityPinScreen> createState() => _SecurityPinScreenState();
}

class _SecurityPinScreenState extends State<SecurityPinScreen> {
  final List<String> _pin = List.filled(6, '');
  int _currentIndex = 0;
  String? _errorMessage;

  void _addNumber(String number) {
    if (_currentIndex < 6) {
      setState(() {
        _pin[_currentIndex] = number;
        _currentIndex++;
      });
    }
  }

  void _removeNumber() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _pin[_currentIndex] = '';
      });
    }
  }

  void _validatePin(String generatedPin) {
    final enteredPin = _pin.join('');
    if (enteredPin == generatedPin) {
      setState(() {
        _errorMessage = null;
      });
      Navigator.pushNamed(context, '/password-success');
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      });
    } else {
      setState(() {
        _errorMessage = 'Invalid PIN. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? generatedPin =
        ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      backgroundColor: const Color(0xFF7AA4FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    'Security Pin',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E3354),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Enter Security Pin',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF7AA4FF),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          6,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _pin[index].isEmpty
                                  ? const Color(0xFFEDF2FF)
                                  : const Color(0xFF7AA4FF),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (generatedPin != null) {
                              _validatePin(generatedPin);
                            } else {
                              setState(() {
                                _errorMessage = 'PIN validation failed.';
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7AA4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            'Accept',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex = 0;
                            for (int i = 0; i < 6; i++) {
                              _pin[i] = '';
                            }
                          });
                        },
                        child: Text(
                          'Clear PIN',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF7AA4FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: Color(0xFF1877F2),
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.google,
                          color: Color(0xFFDB4437),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      '/signup',
                    );
                  },
                  child: Text(
                    "Don't have an account?",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
