import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/organisms/booking_list.dart';
import 'package:myapp/components/pages/booking_first_text_fields_screen.dart';
import 'package:myapp/components/pages/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.grey),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              final mydata = prefs.getStringList('auth_data');
              print(mydata);
              await prefs.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          )
        ],
        backgroundColor: Colors.white,
        elevation: .5,
      ),
      body: BookingList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BookingFirstTextFieldsScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
