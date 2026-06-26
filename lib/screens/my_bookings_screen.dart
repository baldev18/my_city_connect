import 'package:flutter/material.dart';

import '../models/booking_model.dart';
import '../services/database_service.dart';
import '../widgets/app_drawer.dart';

class MyBookingsScreen extends StatelessWidget {
  static const routeName = '/bookings';

  const MyBookingsScreen({super.key});

  String _formatDate(int millis) {
    final date = DateTime.fromMillisecondsSinceEpoch(millis);
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('My Bookings')),
      body: StreamBuilder<List<BookingModel>>(
        stream: DatabaseService().myBookingsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final bookings = snapshot.data ?? [];
          if (bookings.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_month_outlined, size: 72, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No bookings yet'),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      booking.image,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 64,
                        height: 64,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  title: Text(booking.serviceName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${booking.category}\nBooked: ${_formatDate(booking.createdAt)}'),
                  isThreeLine: true,
                  trailing: const Chip(label: Text('Pending')),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
