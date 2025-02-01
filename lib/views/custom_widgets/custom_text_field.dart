import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hineText, this.inputFormatters, this.controller, this.onSaved});

  final String hineText;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty || value == "") {
          return 'Field is required!';
        }
        return null;
      },
      onSaved: onSaved,
      controller: controller,
      inputFormatters: inputFormatters,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: hineText,
        border: getBorder(),
        enabledBorder: getBorder(),
        focusedBorder: getBorder(),
        errorBorder: getBorder(Colors.red),
        focusedErrorBorder: getBorder(Colors.red),
      ),
    );
  }

  OutlineInputBorder getBorder([Color color = Colors.black38]) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}
