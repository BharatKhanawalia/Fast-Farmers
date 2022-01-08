import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fast_farmers/constants.dart';

import 'package:fast_farmers/widgets/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final Widget? icon;
  final Color? borderColor;
  final Color? backgroundColor;
  final Widget? prefix;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? initialValue;
  final String? errorText;
  final FormFieldSetter<String>? onChanged;

  const RoundedInputField({
    this.icon,
    this.backgroundColor,
    this.prefix,
    this.borderColor,
    this.validator,
    this.onSaved,
    this.hintText,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.initialValue,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      width: size.width * 0.8,
      backgroundColor: backgroundColor!,
      borderColor: borderColor!,
      child: TextFormField(
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: null,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          prefix: prefix,
          icon: icon,
          hintText: hintText,
          border: InputBorder.none,
          errorText: errorText,
        ),
      ),
    );
  }
}
