import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String? initialValue;
  final void Function(String?) onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const TextInput({
    Key? key,
    this.initialValue,
    required this.onSaved,
    this.validator,
    this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputDecoration _inputDecoration = InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.all(8.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorStyle: TextStyle(
        height: 0.0,
      ),
    );

    return TextFormField(
      initialValue: initialValue,
      decoration: _inputDecoration,
      onSaved: onSaved,
      validator: validator ?? (val) => null,
      controller: controller,
      keyboardType: keyboardType,
    );
  }
}
