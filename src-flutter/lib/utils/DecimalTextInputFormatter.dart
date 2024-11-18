// ignore: file_names
import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  RegExp regExp() {
    return RegExp(r'^\d*\.?\,?\d*$');
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Permite apenas um ponto ou uma vírgula como separador decimal
    final allowed = regExp();
    final newText = newValue.text.replaceAll(RegExp(r'[^\d.,]'), '');
    if (allowed.hasMatch(newText)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
