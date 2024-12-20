import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

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
                    'Terms And Conditions',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'By Downloading Or Using The App, These Terms Will '
                        'Automatically Apply To You - You Should Make Sure '
                        'Therefore That You Read Them Carefully Before Using The '
                        'App. You\'re Not Allowed To Copy Or Modify The App, Any '
                        'Part Of The App, Or Our Trademarks In Any Way. You\'re '
                        'Not Allowed To Attempt To Extract The Source Code Of The '
                        'App, And You Also Shouldn\'t Try To Translate The App Into '
                        'Other Languages Or Make Derivative Versions.\n\n'
                        'Cartera App Stores And Processes Personal Data That You '
                        'Have Provided To Us, To Provide My Service. It\'s Your '
                        'Responsibility To Keep Your Phone And Access To The App '
                        'Secure. We Therefore Recommend That You Do Not '
                        'Jailbreak Or Root Your Phone, Which Is The Process Of '
                        'Removing Software Restrictions And Limitations Imposed '
                        'By The Official Operating System Of Your Device. It Could '
                        'Make Your Phone Vulnerable To Malware/Virus/Malicious '
                        'Programs, Compromise Your Phone\'s Security Features '
                        'And It Could Mean That The Money Tracker App Won\'t '
                        'Work Properly Or At All.',
                        style: TextStyle(
                          color: Colors.white,
                          height: 1.5,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'I accept all the terms and conditions',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Accept button
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
                    'Accept',
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
