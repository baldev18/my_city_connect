import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/app_user.dart';
import '../models/booking_model.dart';
import '../models/service_provider_model.dart';

class DatabaseService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  String? get currentUid => FirebaseAuth.instance.currentUser?.uid;

  Future<void> saveUser(AppUser user) async {
    await _database.ref('users/${user.uid}').set(user.toMap());
  }

  Future<AppUser?> getCurrentUserData() async {
    final uid = currentUid;
    if (uid == null) return null;

    final snapshot = await _database.ref('users/$uid').get();
    if (!snapshot.exists || snapshot.value == null) return null;

    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    return AppUser.fromMap(data);
  }

  Future<void> createBooking({
    required ServiceProviderModel service,
    required String issueImagePath,
  }) async {
    final uid = currentUid;
    if (uid == null) throw Exception('User not logged in');

    final bookingRef = _database.ref('bookings/$uid').push();
    final booking = BookingModel(
      id: bookingRef.key ?? DateTime.now().millisecondsSinceEpoch.toString(),
      userId: uid,
      serviceId: service.id,
      serviceName: service.name,
      category: service.category,
      image: service.image,
      issueImagePath: issueImagePath,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    await bookingRef.set(booking.toMap());
  }

  Stream<List<BookingModel>> myBookingsStream() {
    final uid = currentUid;
    if (uid == null) return Stream.value([]);

    return _database.ref('bookings/$uid').onValue.map((event) {
      final value = event.snapshot.value;
      if (value == null) return <BookingModel>[];

      final map = Map<dynamic, dynamic>.from(value as Map);
      final bookings = map.values.map((item) {
        return BookingModel.fromMap(Map<dynamic, dynamic>.from(item as Map));
      }).toList();

      bookings.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return bookings;
    });
  }
}
