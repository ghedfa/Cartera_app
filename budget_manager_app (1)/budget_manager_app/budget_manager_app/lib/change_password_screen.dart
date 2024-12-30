import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _errorMessage = '';
  String? _resetLink; // To hold the reset link

  @override
  void initState() {
    super.initState();
    _checkPasswordResetLink();
  }

  // Check if the app was opened via the reset password link
  Future<void> _checkPasswordResetLink() async {
    _resetLink = Uri.base.toString(); // Capture the current URL
    // Validate the link with Firebase
    bool isLinkValid =
        await FirebaseAuth.instance.isSignInWithEmailLink(_resetLink!);
    if (!isLinkValid) {
      setState(() {
        _errorMessage = 'Invalid password reset link.';
      });
    }
  }

  // Reset the password using the link and new password
  Future<void> _resetPassword() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        await FirebaseAuth.instance.confirmPasswordReset(
          code: _resetLink!, // Use the reset link
          newPassword: _passwordController.text,
        );
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to reset password. Please try again.';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Passwords do not match.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Enter New Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm New Password'),
              obscureText: true,
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: _resetPassword,
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
