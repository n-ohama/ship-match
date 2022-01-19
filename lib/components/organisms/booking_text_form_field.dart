import 'package:flutter/material.dart';

class BookingTextFormField extends StatelessWidget {
  final Function(String) onSavedFunc;
  final String label;
  final String hint;
  const BookingTextFormField({
    required this.onSavedFunc, required this.label, this.hint = '',
  });

  @override
  Widget build(BuildContext context) {
    final _focusNode = FocusNode();

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(label, textAlign: TextAlign.left),
        ),
        TextFormField(
          focusNode: _focusNode,
          style: const TextStyle(fontSize: 14, height: 1),
          keyboardType: label != '出港場所' ? TextInputType.number : null,
          validator: (value) {
            if(value!.trim().isEmpty) {
              return '入力に不備があります。';
            }
            return null;
          },
          onSaved: (text) {
            onSavedFunc(text!);
            if(_focusNode.hasFocus) {
              _focusNode.unfocus();
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            errorBorder:  const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
