import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
  final FormFieldSetter<String>? onsaved;
  final String? Function(String?)? validator;
  final String texthint;

  const MyTextForm(
      {super.key,
      required this.onsaved,
      required this.validator,
      required this.texthint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        fillColor: const Color(0xffF5F5F5),
        filled: true,
        hintStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: texthint,
      ),
      validator: validator,
      onSaved: onsaved,
    );
  }
}
