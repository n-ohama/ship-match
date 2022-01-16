import 'package:flutter/material.dart';

class BookingRequiredField extends StatelessWidget {
  final Function(String) onPress;
  final String label;
  final String hint;
  const BookingRequiredField({
    required this.onPress, required this.label, this.hint = '',
  });

  @override
  Widget build(BuildContext context) {
    final _focusNode = FocusNode();

    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(label, textAlign: TextAlign.left),
        ),
        TextFormField(
          focusNode: _focusNode,
          onSaved: (text) {
            onPress(text!);
            if(_focusNode.hasFocus) {
              _focusNode.unfocus();
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            errorBorder:  const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 5),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
