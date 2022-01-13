import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/model/booking.dart';

final detailDataStreamProvider = StreamProvider.autoDispose.family<Booking, String>((ref, id) {
  final collection = FirebaseFirestore.instance.collection('ship_booking');
  final stream = collection.doc(id).snapshots().map(
    (e) => Booking.fromJson(e.data()!),
  );
  return stream;
});
