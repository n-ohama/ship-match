import 'package:flutter/material.dart';
import 'package:myapp/components/organisms/booking_text_form_field.dart';
import 'package:myapp/components/pages/booking_second_text_field_screen.dart';
import 'package:myapp/model/booking_text_field.dart';

class BookingFirstTextFieldsScreen extends StatelessWidget {
  static const routeName = '/bookingFirstTextFieldsScreen';

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
                // _formKey.currentState?.save();
                Navigator.pushNamed(context, BookingSecondTextFieldScreen.routeName);
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
              children: [
                BookingTextFormField(
                  label: '料金',
                  hint: 'ex) 2000',
                  onPress: (value) => BookingFirstInputs.instance.price = int.parse(value),
                ),
                BookingTextFormField(
                  label: '出港場所',
                  hint: '沖縄県宜野湾市大山　新漁港',
                  onPress: (value) => BookingFirstInputs.instance.address = value,
                ),
                BookingTextFormField(
                  label: '必要人数',
                  onPress: (value) => BookingFirstInputs.instance.requireNumber = int.parse(value),
                ),
                BookingTextFormField(
                  label: '最大人数',
                  onPress: (value) => BookingFirstInputs.instance.capacity = int.parse(value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
