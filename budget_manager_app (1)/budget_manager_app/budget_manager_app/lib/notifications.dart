import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationItem> notifications = [
    NotificationItem(
      title: 'New Feature Available',
      message: 'Check out our new budget tracking feature!',
      timestamp: '2 hours ago',
      icon: Icons.star,
    ),
    NotificationItem(
      title: 'Payment Due',
      message: 'Your credit card payment is due tomorrow',
      timestamp: '5 hours ago',
      icon: Icons.payment,
    ),
    NotificationItem(
      title: 'Budget Alert',
      message: 'You\'ve reached 80% of your monthly budget',
      timestamp: '1 day ago',
      icon: Icons.warning,
    ),
    NotificationItem(
      title: 'Savings Goal',
      message: 'Congratulations! You\'ve reached your savings goal',
      timestamp: '2 days ago',
      icon: Icons.savings,
    ),
  ];

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B7BE5),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Notifications List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Stack(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          leading: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4B7BE5).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              notification.icon,
                              color: const Color(0xFF4B7BE5),
                            ),
                          ),
                          title: Text(
                            notification.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                notification.message,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notification.timestamp,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.grey[400],
                            ),
                            onPressed: () => _deleteNotification(index),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
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
    );
  }
}

class NotificationItem {
  final String title;
  final String message;
  final String timestamp;
  final IconData icon;

  NotificationItem({
    required this.title,
    required this.message,
    required this.timestamp,
    required this.icon,
  });
}
