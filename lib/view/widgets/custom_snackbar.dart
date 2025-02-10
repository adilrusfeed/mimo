import 'package:dfine_task/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:enefty_icons/enefty_icons.dart';


void showCustomSnackBar(
    {required BuildContext context,
    required SnackBarType type,
    IconData? icon,
    String? title,
    String? content,
    bool isColor = false}) {
  Size size = MediaQuery.of(context).size;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.04),
        side: const BorderSide(width: 2, color: Colors.transparent),
      ),
      padding: EdgeInsets.all(size.width * 0.04),
      content: Row(
        children: [
          Icon(
            icon ?? _getIcon(type),
            size: 25,
            color: Colors.white,
          ),
          SizedBox(width: size.width * 0.01),
          SizedBox(
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...{
                  CustomText(
                    textAlign: TextAlign.start,
                    text: title,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                },
                CustomText(
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w600,
                  text: content ?? _getDefaultContent(type),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

IconData _getIcon(SnackBarType type) {
  switch (type) {
    case SnackBarType.information:
      return EneftyIcons.information_bold;
    case SnackBarType.warning:
      return EneftyIcons.warning_2_bold;
    case SnackBarType.error:
      return EneftyIcons.danger_bold;
    case SnackBarType.success:
      return EneftyIcons.tick_circle_bold;
    }
}

String _getDefaultContent(SnackBarType type) {
  switch (type) {
    case SnackBarType.information:
      return 'This is an information message.';
    case SnackBarType.warning:
      return 'This is a warning message.';
    case SnackBarType.error:
      return 'This is an error message.';
    case SnackBarType.success:
      return 'This is a success message.';
    }
}
