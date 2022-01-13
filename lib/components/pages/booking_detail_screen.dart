import 'package:flutter/material.dart';
import 'package:myapp/components/organisms/booking_detail.dart';

class BookingDetailScreen extends StatelessWidget {
  static const routeName = '/bookingDetailScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: .3,
      ),
      body: const BookingDetail(bookingId: 'bookingId'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
