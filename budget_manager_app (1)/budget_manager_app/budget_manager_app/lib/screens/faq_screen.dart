import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        FAQItem(
          question: 'How to use Cartera?',
          answer: 'Cartera is an easy-to-use expense tracking app. Simply add your income and expenses, categorize them, and view your financial reports. You can also set budgets and receive notifications.',
        ),
        FAQItem(
          question: 'How much does it cost to use Cartera?',
          answer: 'Cartera offers both free and premium plans. The basic features are free to use, while premium features require a subscription.',
        ),
        FAQItem(
          question: 'How to contact support?',
          answer: 'You can contact our support team through the Contact Us section or email us at support@cartera.com',
        ),
        FAQItem(
          question: 'How can I reset my password if I forget it?',
          answer: 'Click on "Forgot Password" on the login screen and follow the instructions sent to your registered email.',
        ),
        FAQItem(
          question: 'Are there any privacy or data security measures in place?',
          answer: 'Yes, we use industry-standard encryption and security measures to protect your data. Your financial information is never shared without your consent.',
        ),
        FAQItem(
          question: 'Can I customize settings within the application?',
          answer: 'Yes, you can customize various settings including currency, language, notifications, and theme preferences in the Settings menu.',
        ),
        FAQItem(
          question: 'How can I delete my account?',
          answer: 'Go to Settings > Account > Delete Account. Please note this action cannot be undone.',
        ),
        FAQItem(
          question: 'How do I access my expense history?',
          answer: 'You can view your expense history in the Transactions tab. Use filters to sort by date, category, or amount.',
        ),
        FAQItem(
          question: 'Can I use the app offline?',
          answer: 'Yes, basic features work offline. Your data will sync when you reconnect to the internet.',
        ),
      ],
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Column(
        children: [
          ListTile(
            onTap: () => setState(() => isExpanded = !isExpanded),
            title: Text(
              widget.question,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF2D3142),
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: const Color(0xFF4B7BE5),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.answer,
                style: TextStyle(
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
