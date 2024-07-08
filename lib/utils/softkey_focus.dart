import 'package:flutter/material.dart';

FocusNode? focusNode;

/// Hide the soft keyboard.
void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
