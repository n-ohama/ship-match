import 'package:flutter/material.dart';
import 'package:myapp/components/organisms/booking_list.dart';

class ListDataScreen extends StatelessWidget {
  static const routeName = '/listDataScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: .3,
      ),
      body: BookingList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
