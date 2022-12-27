import 'package:flutter/material.dart';

class CustomDropdownField extends StatefulWidget {
  final bool? autoCorrect;
  final bool? obscureText;
  final String? fieldName;
  final String? hintText;
  final TextAlign? alignCenter;
  final TextInputAction action;
  final void Function(String)? onChanged;

  final List<String> list;
  const CustomDropdownField({
    Key? key,
    required this.autoCorrect,
    required this.obscureText,
    required this.list,
    required this.fieldName,
    required this.hintText,
    required this.action,
    required this.onChanged,
    this.alignCenter,
  }) : super(key: key);

  @override
  _CustomDropdownFieldState createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 8.0,
      ),
      height: 75.0,
      child: DropdownButtonFormField<String?>(
        icon: const SizedBox(),
        value: value,
        onChanged: (text) {
          setState(() {
            value = text;
          });

          widget.onChanged?.call(text!);
        },
        items: widget.list
            .map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e, style: const TextStyle(color: Colors.grey)),
                ))
            .toList(),
        style: TextStyle(color: Colors.grey.shade700, fontSize: 16.0),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 8.0,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
            gapPadding: 8.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
            gapPadding: 8.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(8.0),
            gapPadding: 8.0,
          ),
          hintText: widget.hintText,
          suffixIcon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
