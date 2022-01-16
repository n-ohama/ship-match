import 'package:flutter/material.dart';
import 'package:myapp/components/organisms/booking_required_field.dart';
import 'package:myapp/components/pages/booking_add_title_screen.dart';
import 'package:myapp/model/booking_text_field.dart';

class BookingAddRequiredFieldsScreen extends StatelessWidget {
  static const routeName = '/bookingAddRequiredFieldsScreen';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: TextButton(
          child: const Text('キャンセル', style: TextStyle(color: Colors.grey)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text('次へ'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                _formKey.currentState?.save();
                Navigator.pushNamed(context, BookingAddTitleScreen.routeName);
              }
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: .5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BookingRequiredField(
                  label: '料金',
                  hint: 'ex) 2000',
                  onPress: (value) => BookingTextField.instance.price = int.parse(value),
                ),
                BookingRequiredField(
                  label: '出港場所',
                  hint: '沖縄県宜野湾市大山　新漁港',
                  onPress: (value) => BookingTextField.instance.address = value,
                ),
                BookingRequiredField(
                  label: '必要人数',
                  onPress: (value) => BookingTextField.instance.requireNumber = int.parse(value),
                ),
                BookingRequiredField(
                  label: '最大人数',
                  onPress: (value) => BookingTextField.instance.capacity = int.parse(value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
