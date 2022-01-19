import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/atoms/auth_text_field.dart';
import 'package:myapp/components/pages/booking_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup';
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Map<String, String> _authData = {
      'name': '',
      'email': '',
      'password': '',
    };

    void signUp(String email, String password, String name) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password
        );
        final User? user = userCredential.user;
        await user?.updateDisplayName(name);
        if(user?.uid != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLogin', true);
          Navigator.pushReplacementNamed(context, BookingListScreen.routeName);
        }

      } on FirebaseAuthException catch(e) {
        String errorMessage = '';
        if (e.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email.';
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
                  onSavedFunc: (text) => _authData['name'] = text,
                  label: 'あなたのお名前',
                ),
                const SizedBox(height: 8),
                AuthTextField(
                  onSavedFunc: (text) => _authData['email'] = text,
                  label: 'メールアドレス',
                ),
                const SizedBox(height: 8),
                AuthTextField(
                  onSavedFunc: (text) => _authData['password'] = text,
                  label: 'パスワード', isPassword: true,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  child: const Text(
                    '新規登録する', style: TextStyle(fontSize: 16),
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
                    signUp(_authData['email']!, _authData['password']!, _authData['name']!);
                  },
                ),
                TextButton(
                  child: const Text('すでにアカウントを持っている'),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
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
