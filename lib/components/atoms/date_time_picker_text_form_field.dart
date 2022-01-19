import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DateTimePickerTextFormField extends StatefulWidget {
  final Function(DateTime) onSavedFunc;
  final String hint;
  const DateTimePickerTextFormField({
    required this.onSavedFunc, this.hint = '',
  });

  @override
  State<DateTimePickerTextFormField> createState() => _DateTimePickerTextFormFieldState();
}

class _DateTimePickerTextFormFieldState extends State<DateTimePickerTextFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text('集合時間', textAlign: TextAlign.left),
        ),
        TextFormField(
          style: const TextStyle(fontSize: 14),
          controller: _controller,
          readOnly: true,
          validator: (value) {
            if(value!.trim().isEmpty) {
              return '入力に不備があります。';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            border: const OutlineInputBorder(),
            errorBorder:  const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          onTap: () {
            DatePicker.showDateTimePicker(
              context,
              showTitleActions: true,
              onConfirm: (date) {
                widget.onSavedFunc(date);
                _controller.text = date.toString();
              },
              currentTime: DateTime.now(),
              locale: LocaleType.jp,
            );
          },
        ),
      ],
    );
  }
}
