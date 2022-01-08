import 'package:flutter/material.dart';

import 'package:fast_farmers/constants.dart';

import 'package:fast_farmers/widgets/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final String? hintText;
  final String? initialValue;
  final String? errorText;
  final Color? borderColor;
  final Color? backgroundColor;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final FocusNode? focusNode;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  const RoundedPasswordField({
    this.hintText,
    this.validator,
    this.borderColor,
    this.backgroundColor,
    this.onSaved,
    this.obscureText,
    this.suffixIcon,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.focusNode,
    this.errorText,
    this.textInputAction,
  });

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      width: size.width * 0.8,
      borderColor: widget.borderColor!,
      backgroundColor: widget.backgroundColor!,
      child: TextFormField(
        initialValue: widget.initialValue,
        key: ValueKey('password'),
        controller: widget.controller,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        validator: widget.validator,
        keyboardType: TextInputType.visiblePassword,
        obscureText: widget.obscureText!,
        cursorColor: kPrimaryColor,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: widget.suffixIcon,
          border: InputBorder.none,
          errorMaxLines: 2,
          errorText: widget.errorText,
        ),
      ),
    );
  }
}
