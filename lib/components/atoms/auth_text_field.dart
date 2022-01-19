import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final Function(String) onSavedFunc;
  final String label;
  final bool isPassword;
  const AuthTextField({
    required this.onSavedFunc, required this.label, this.isPassword = false,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      obscureText: widget.isPassword ? _obscure : false,
      style: const TextStyle(fontSize: 14, height: 1),
      keyboardType: widget.label == 'メールアドレス' ? TextInputType.emailAddress : null,
      validator: (value) {
        if(value!.trim().isEmpty) {
          return '入力に不備があります。';
        }
        return null;
      },
      onSaved: (text) {
        widget.onSavedFunc(text!);
      },
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.isPassword ? IconButton(
          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() => _obscure = !_obscure);
          },
        ) : null,
        border: const OutlineInputBorder(),
        errorBorder:  const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
