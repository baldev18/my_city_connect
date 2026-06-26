import 'package:flutter/material.dart';

import '../services/launcher_service.dart';
import '../widgets/app_drawer.dart';

class ContactUsScreen extends StatelessWidget {
  static const routeName = '/contact';

  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const phone = '+919876543210';
    const website = 'https://example.com';
    const email = 'support@mycityconnect.com';

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Contact Us')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.support_agent, size: 90, color: Color(0xFF2563EB)),
            const SizedBox(height: 18),
            const Text(
              'Need help? Contact MyCityConnect support.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => LauncherService.call(phone),
              icon: const Icon(Icons.phone),
              label: const Text('Call Support'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => LauncherService.sms(phone, message: 'Hello MyCityConnect support, I need help.'),
              icon: const Icon(Icons.sms),
              label: const Text('Send SMS'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => LauncherService.email(email),
              icon: const Icon(Icons.email),
              label: const Text('Send Email'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => LauncherService.openUrl(website),
              icon: const Icon(Icons.language),
              label: const Text('Open Website'),
            ),
          ],
        ),
      ),
    );
  }
}
