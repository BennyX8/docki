import 'package:flutter/material.dart';

class CustomMultilineTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool? autoCorrect;
  final bool? obscureText;
  final String? fieldName;
  final String? hintText;
  final TextAlign? alignCenter;
  final int? maxLines;
  const CustomMultilineTextField({
    Key? key,
    @required this.autoCorrect,
    @required this.obscureText,
    @required this.controller,
    @required this.fieldName,
    @required this.hintText,
    this.alignCenter,
    this.maxLines,
  }) : super(key: key);

  @override
  _CustomMultilineTextFieldState createState() =>
      _CustomMultilineTextFieldState();
}

class _CustomMultilineTextFieldState extends State<CustomMultilineTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 15.0,
      ),
      child: TextFormField(
        autocorrect: widget.autoCorrect!,
        obscureText: widget.obscureText!,
        controller: widget.controller!,
        minLines: widget.maxLines != null ? widget.maxLines! : 1,
        maxLines: widget.maxLines != null ? widget.maxLines! : 1,
        textAlign:
            widget.alignCenter != null ? widget.alignCenter! : TextAlign.start,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
