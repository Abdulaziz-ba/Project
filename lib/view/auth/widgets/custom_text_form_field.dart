import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  final String hint;

  final void Function(String?)? onSave;
  final FormFieldValidator<String>? validator;

  CustomTextFormField({
    this.text = '',
    this.hint = '',
    // ignore: prefer_equal_for_default_values
    this.onSave,
    this.validator,
  });

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            onSaved: onSave,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF302F2F),
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
