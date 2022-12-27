import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final bool? autoCorrect;
  final bool? obscureText;
  final String? fieldName;
  final String? hintText;
  final TextAlign? alignCenter;
  final TextInputAction action;

  final void Function(String)? onChanged;

  final TextEditingController? controller;
  const CustomPasswordField({
    Key? key,
    required this.autoCorrect,
    required this.obscureText,
    required this.controller,
    required this.fieldName,
    required this.hintText,
    required this.onChanged,
    required this.action,
    this.alignCenter,
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isValid = false;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        // vertical: 10.0,
      ),
      child: TextFormField(
        autocorrect: widget.autoCorrect!,
        obscureText: obscure,
        controller: widget.controller!,
        textInputAction: widget.action,
        textCapitalization: widget.fieldName != 'email'
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        textAlign:
            widget.alignCenter != null ? widget.alignCenter! : TextAlign.start,
        style: TextStyle(
          color: Colors.orange.shade300.withOpacity(0.8),
        ),
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () => _obscureText(),
              child: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.orange.shade300.withOpacity(0.7),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.fieldName == 'email'
                    ? isValid
                        ? Colors.orange.shade300.withOpacity(0.7)
                        : Colors.red
                    : Colors.orange.shade300.withOpacity(0.7),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.shade300.withOpacity(0.7),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6),
            )),
        onChanged: (text) {
          widget.onChanged!(text);

          if (widget.fieldName == 'email') {
            setState(() {
              isValid = EmailValidator.validate(text);
            });
          }
        },
      ),
    );
  }

  void _obscureText() {
    setState(() {
      obscure = !obscure;
    });
  }
}
