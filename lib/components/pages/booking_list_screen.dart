import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/organisms/booking_list.dart';
import 'package:myapp/components/pages/booking_first_text_fields_screen.dart';
import 'package:myapp/components/pages/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingListScreen extends StatelessWidget {
  static const routeName = '/list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            child: const Text('ログアウト'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLogin', false);
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
          )
        ],
        backgroundColor: Colors.white,
        elevation: .5,
      ),
      body: BookingList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, BookingFirstTextFieldsScreen.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
