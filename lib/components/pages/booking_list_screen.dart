import 'package:flutter/material.dart';
import 'package:myapp/components/organisms/booking_list.dart';
import 'package:myapp/components/pages/booking_add_required_fields_screen.dart';

class BookingListScreen extends StatelessWidget {
  static const routeName = '/bookingListScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: .5,
      ),
      body: BookingList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, BookingAddRequiredFieldsScreen.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
