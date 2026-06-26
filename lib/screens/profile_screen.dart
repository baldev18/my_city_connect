import 'package:flutter/material.dart';

import '../services/database_service.dart';
import '../widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder(
        future: DatabaseService().getCurrentUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final user = snapshot.data;
          if (user == null) {
            return const Center(child: Text('User data not found'));
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(0xFF2563EB),
                  child: Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                    style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Column(
                    children: [
                      ListTile(leading: const Icon(Icons.person), title: const Text('Name'), subtitle: Text(user.name)),
                      const Divider(height: 0),
                      ListTile(leading: const Icon(Icons.email), title: const Text('Email'), subtitle: Text(user.email)),
                      const Divider(height: 0),
                      ListTile(leading: const Icon(Icons.phone), title: const Text('Phone'), subtitle: Text(user.phone)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
