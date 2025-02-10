import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextFields extends StatelessWidget {
  const CustomTextFields({
    super.key,
    this.type = TextFieldType.none,
    this.controller,
    this.cnfController,
    this.hint,
    this.inputFormatter,
    this.onTap,
    this.obscureText = true,
    this.hintStyle,
  });

  final TextFieldType type;
  final VoidCallback? onTap;

  final TextEditingController? controller;
  final TextEditingController? cnfController;
  final String? hint;
  final TextInputFormatter? inputFormatter;

  final bool obscureText;
  
  final dynamic hintStyle;

  @override
  Widget build(BuildContext context) {
    bool isPassword = type == TextFieldType.password;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        inputFormatters: inputFormatter != null ? [inputFormatter!] : [],
        keyboardType: _getKeyboardType(),
        obscureText: isPassword && obscureText,
        validator: (value) => _validator(value),
        controller: controller,
        onTap: onTap,
        decoration: InputDecoration(
            enabledBorder: _outlineBorder(),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            disabledBorder: _outlineBorder(),
            border: _outlineBorder(),
            hintText: hint,
            labelStyle: const TextStyle(color: Colors.black),
            focusColor: Colors.grey,
            focusedBorder: _outlineBorder()),
      ),
    );
  }

  OutlineInputBorder _outlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 2,
        style: BorderStyle.solid,
        color: Colors.grey,
      ),
    );
  }

  TextInputType _getKeyboardType() {
    switch (type) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.password:
        return TextInputType.text;
      case TextFieldType.name:
        return TextInputType.name;
      default:
        return TextInputType.text;
    }
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter $hint";
    } else if (type == TextFieldType.email && !EmailValidator.validate(value)) {
      return "Please enter a valid email address";
    } else if (type == TextFieldType.password && value.length < 6) {
      return 'Password should be at least 6 characters';
    } else if (type == TextFieldType.confirmPassword &&
        value != controller?.text) {
      return 'Passwords do not match';
    }
    return null;
  }


}

/////////////////////////////////////////


class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.decoration,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.w500,
    this.overflow = false,
    this.size = 15,
  });

  final String text;
  final TextAlign textAlign;
  final TextDecoration? decoration;
  final Color? color;
  final FontWeight fontWeight;
  final bool overflow;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: overflow ? 1 : null,
      overflow: overflow ? TextOverflow.ellipsis : null,
      style: TextStyle(
        decoration: decoration,
        color: color ?? Colors.black,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}

//////////////////////////////////////////

enum TextFieldType {
  password,
  confirmPassword,
  email,
  number,
  search,
  amount,
  dropdown,
  name,
  phone,
  address,
  multiline,
  url,
  date,
  time,
  pin,
  none
}

enum SnackBarType { information, warning, error, success }
