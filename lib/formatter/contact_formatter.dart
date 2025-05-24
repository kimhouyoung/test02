import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ContactNumberFormatter extends TextInputFormatter {
  static final regex = RegExp(r'^(\d{3})?(\d{4})-?(\d{4})$');

  @override
  TextEditingValue formatEditUpdate(final TextEditingValue oldValue,final TextEditingValue newValue) {

    final String newText = newValue.text.replaceAllMapped(regex, (match) {
      return '${match.group(1)}-${match.group(2)}-${match.group(3)}';
    });

    return TextEditingValue(
      text: newText,
      selection: TextSelection.fromPosition(
        TextPosition(offset: newText.length),
      ),
    );
  }
}