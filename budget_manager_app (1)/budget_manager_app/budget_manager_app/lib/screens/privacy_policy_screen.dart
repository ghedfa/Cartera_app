import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B7BE5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    'At Cartera, We Value Your Privacy And Are Committed To '
                    'Protecting Your Personal Information. This Privacy Policy '
                    'Explains How We Collect, Use, Store, And Protect The Data '
                    'You Provide When Using Our App. We Collect Personal '
                    'Information Such As Your Name, Email Address, And '
                    'Financial Data, Which Is Used To Provide And Enhance Our '
                    'Services, Including Budgeting Tools, Transaction Tracking, '
                    'And Predictions. We May Also Collect Non-Personal Data, '
                    'Such As Device Information And App Usage Statistics, To '
                    'Improve App Functionality. We Will Never Share Your '
                    'Personal Information With Third Parties Without Your '
                    'Consent, Unless Required By Law. By Using Our App, You '
                    'Consent To The Collection And Use Of Your Information As '
                    'Outlined In This Policy. We Are Committed To Ensuring '
                    'That Your Data Is Handled Securely And In Compliance '
                    'With Applicable Data Protection Laws.',
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.5,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            
            // Close button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
