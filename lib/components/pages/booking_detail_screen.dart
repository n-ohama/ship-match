import 'package:flutter/material.dart';
import 'package:myapp/components/organisms/booking_detail.dart';

class BookingDetailScreen extends StatelessWidget {
  final String id;
  const BookingDetailScreen(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Flutter Demo', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: .5,
      ),
      body: BookingDetail(bookingId: id),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.send),
      ),
    );
  }
}
