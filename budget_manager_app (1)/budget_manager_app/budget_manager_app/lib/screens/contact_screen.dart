import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSocialMediaButton(
          icon: FontAwesomeIcons.facebook,
          text: 'Facebook',
          onTap: () => _launchUrl('https://facebook.com/cartera'),
        ),
        const SizedBox(height: 16),
        _buildSocialMediaButton(
          icon: FontAwesomeIcons.whatsapp,
          text: 'Whatsapp',
          onTap: () => _launchUrl('https://wa.me/1234567890'),
        ),
        const SizedBox(height: 16),
        _buildSocialMediaButton(
          icon: FontAwesomeIcons.instagram,
          text: 'Instagram',
          onTap: () => _launchUrl('https://instagram.com/cartera'),
        ),
      ],
    );
  }

  Widget _buildSocialMediaButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
          ),
          child: Row(
            children: [
              FaIcon(icon, color: const Color(0xFF4B7BE5), size: 24),
              const SizedBox(width: 16),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D3142),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF4B7BE5),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
