import 'package:flutter/material.dart';
import 'package:myapp/components/organisms/booking_list.dart';

class BookingListScreen extends StatelessWidget {
  static const routeName = '/listDataScreen';
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
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
