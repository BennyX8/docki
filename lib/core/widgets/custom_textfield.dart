import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final bool? autoCorrect;
  final bool? obscureText;
  final String? fieldName;
  final String? hintText;
  final TextAlign? alignCenter;

  final TextInputAction action;

  final void Function(String)? onChanged;

  final TextEditingController? controller;
  const CustomTextField({
    Key? key,
    required this.autoCorrect,
    required this.obscureText,
    required this.controller,
    required this.fieldName,
    required this.hintText,
    required this.action,
    required this.onChanged,
    this.alignCenter,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 8.0,
      ),
      // height: 85.0,
      child: TextFormField(
        autocorrect: widget.autoCorrect!,
        obscureText: widget.obscureText!,
        controller: widget.controller!,
        textInputAction: widget.action,
        textCapitalization: widget.fieldName != 'email'
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        textAlign:
            widget.alignCenter != null ? widget.alignCenter! : TextAlign.start,
        style: TextStyle(
          color: widget.fieldName == 'email'
              ? isEmailValid
                  ? Colors.orange.shade300.withOpacity(0.8)
                  : Colors.red
              : Colors.orange.shade300.withOpacity(0.8),
        ),
        decoration: InputDecoration(
            suffixIcon: widget.fieldName == 'email' &&
                    widget.controller!.text.isNotEmpty
                ? Icon(
                    isEmailValid ? Icons.check : Icons.close,
                    color: widget.fieldName == 'email'
                        ? isEmailValid
                            ? Colors.orange.shade300.withOpacity(0.7)
                            : Colors.red
                        : Colors.orange.shade300.withOpacity(0.7),
                  )
                : const SizedBox(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 16.0,
            ),
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.fieldName == 'email'
                    ? isEmailValid
                        ? Colors.orange.shade300.withOpacity(0.7)
                        : Colors.red
                    : Colors.orange.shade300.withOpacity(0.7),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.shade300.withOpacity(0.7),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            )),
        onChanged: (text) {
          widget.onChanged!(text);

          if (widget.fieldName == 'email') {
            setState(() {
              isEmailValid = EmailValidator.validate(text);
            });
          }
        },
      ),
    );
  }
}
