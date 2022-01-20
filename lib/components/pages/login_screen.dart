import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/atoms/auth_text_field.dart';
import 'package:myapp/components/pages/booking_list_screen.dart';
import 'package:myapp/components/pages/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Map<String, String> authData = {
      'email': '',
      'password': '',
    };

    void login(String email, String password) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password
        );
        final User? user = userCredential.user;
        if(user != null) {
          final myData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLogin', true);
          await prefs.setStringList(
            'auth_data', [user.uid, myData.data()!['name'], myData.data()!['email']]
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => BookingListScreen()),
          );
        }
      } on FirebaseAuthException catch(e) {
        String errorMessage = '';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        }

        showDialog(context: context, builder: (ctx) => AlertDialog(
          title: Text(errorMessage),
          actions: [
            TextButton(child: const Text('OK'), onPressed: () {
              Navigator.of(ctx).pop();
            })
          ],
        ));
      }

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: .5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AuthTextField(
                  onSavedFunc: (text) => authData['email'] = text,
                  label: 'メールアドレス'
                ),
                const SizedBox(height: 8),
                AuthTextField(
                  onSavedFunc: (text) => authData['password'] = text,
                  label: 'パスワード', isPassword: true,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  child: const Text(
                    'ログインする', style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    if(!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    login(authData['email']!, authData['password']!);
                  },
                ),
                TextButton(
                  child: const Text('まだアカウントを持っていない'),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => SignUpScreen()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
