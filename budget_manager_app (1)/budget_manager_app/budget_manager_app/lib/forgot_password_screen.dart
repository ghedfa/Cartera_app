import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _errorMessage = '';
  String _successMessage = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to check if the email exists and send the reset link
  Future<void> _sendResetEmail() async {
    String email = _emailController.text.trim();
    setState(() {
      _errorMessage = '';
      _successMessage = '';
    });

    if (email.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your email address.';
      });
      return;
    }

    try {
      // Send the password reset email using Firebase Authentication
      await _auth.sendPasswordResetEmail(email: email);

      setState(() {
        _successMessage = 'A password reset link has been sent to your email!';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7AA4FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Lock Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lock_reset_rounded,
                    size: 50,
                    color: Color(0xFF7AA4FF),
                  ),
                ),
                const SizedBox(height: 40),
                // Title and Description
                Text(
                  'Forgot Password?',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Enter your email address below to receive password reset instructions.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Email Input Container
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Address',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDF2FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFE0E7FF),
                          ),
                        ),
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'example@example.com',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.black38,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xFF7AA4FF),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      if (_successMessage.isNotEmpty)
                        Text(
                          _successMessage,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _sendResetEmail,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7AA4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Send Reset Link',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Back to Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Remember your password? ",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
