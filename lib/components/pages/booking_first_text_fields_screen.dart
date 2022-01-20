import 'package:flutter/material.dart';
import 'package:myapp/components/atoms/date_time_picker_text_form_field.dart';
import 'package:myapp/components/organisms/booking_text_form_field.dart';
import 'package:myapp/components/pages/booking_second_text_field_screen.dart';

class BookingFirstTextFieldsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Map<String, dynamic> _inputData = {
      'price': 0,
      'address': '',
      'requireNumber': 0,
      'capacity': 0,
      'leaveDateTime': DateTime(2022),
    };
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: TextButton(
          child: const Text('キャンセル', style: TextStyle(color: Colors.blueGrey)),
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
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                _formKey.currentState!.save();
                // setState(() {});
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BookingSecondTextFieldScreen(_inputData)),
                );
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
                  label: '出港場所',
                  hint: '沖縄県宜野湾市大山　新漁港',
                  onSavedFunc: (value) => _inputData['address'] = value,
                ),
                BookingTextFormField(
                  label: '料金',
                  onSavedFunc: (value) => _inputData['price'] = int.parse(value),
                ),
                BookingTextFormField(
                  label: '必要人数',
                  onSavedFunc: (value) => _inputData['requireNumber'] = int.parse(value),
                ),
                BookingTextFormField(
                  label: '最大人数',
                  onSavedFunc: (value) => _inputData['capacity'] = int.parse(value),
                ),
                DateTimePickerTextFormField(
                  onSavedFunc: (value) => _inputData['leaveDateTime'] = value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
