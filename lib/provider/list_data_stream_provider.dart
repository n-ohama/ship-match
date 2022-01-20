import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/model/booking.dart';

final listDataStreamProvider = StreamProvider.autoDispose<List<Booking>>((ref) {
  final collection = FirebaseFirestore.instance.collection('ship_booking')
      .orderBy('createdAt', descending: true);
  final stream = collection.snapshots().map(
    (e) => e.docs.map((e) => Booking.fromJson(e.data())).toList(),
  );
  return stream;
});